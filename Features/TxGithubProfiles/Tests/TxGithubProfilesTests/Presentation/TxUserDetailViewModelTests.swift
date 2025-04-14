import XCTest
import Combine
@testable import TxGithubProfiles
import Resolver
import TxApiClient
import TxLocalization
import TxNetworkModels

class TxUserDetailViewModelTests: XCTestCase {
    var mockRepository: TxMockUserRepository!
    var mockNavigation: TxMockGithubProfileNavigation!
    var mockApiClient: TxMockApiClient!
    var viewModel: TxUserDetailViewModel!
    var cancellables: Set<AnyCancellable>!
    var mockGetUserDetailUseCase: TxGetUserDetailUseCaseImpl!

    override func setUp() {
        super.setUp()
        Resolver.register { L10n() }.scope(ResolverScope.application)
        mockRepository = TxMockUserRepository()
        mockNavigation = TxMockGithubProfileNavigation()
        mockApiClient = TxMockApiClient()
        
        // Register mock dependencies in Resolver
        Resolver.register { self.mockNavigation as TxGithubProfileNavigation }
        Resolver.register { self.mockApiClient as TxApiClientProtocol }
        Resolver.register { self.mockRepository as TxUserRepository }
        mockGetUserDetailUseCase = TxGetUserDetailUseCaseImpl()
        Resolver.register { self.mockGetUserDetailUseCase as TxGetUserDetailUseCase }

        viewModel = TxUserDetailViewModel(loginUsername: "testuser")
        cancellables = []
    }
    
    override func tearDown() {
        mockRepository = nil
        mockNavigation = nil
        mockApiClient = nil
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testInitialState() {
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.user)
        XCTAssertFalse(viewModel.dataLoaded)
    }
    
    @MainActor
    func testFetchUserDetailSuccess() async {
        // Given
        let expectedUser = TxTestData.testUserDetail
        mockRepository.userDetails["testuser"] = expectedUser
        
        // Create expectation for state change
        let expectation = expectation(description: "State should update with user data")
        var receivedUser: TxUserDetailUIModel?
        
        viewModel.$user
            .dropFirst() // Skip initial nil state
            .sink { user in
                receivedUser = user
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        viewModel.fetchUserDetail()
        
        // Then
        await fulfillment(of: [expectation], timeout: 1.0)
        
        XCTAssertNotNil(receivedUser)
        XCTAssertEqual(receivedUser?.baseInfo.loginUsername, expectedUser.username)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.dataLoaded)
    }
    
    @MainActor
    func testFetchUserDetailWhenLoading_shouldNotFetch() async {
        // Given
        viewModel.isLoading = true
        
        // When
        viewModel.fetchUserDetail()
        
        // Then
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(mockRepository.getUserDetailCallCount, 0)
    }
    
    @MainActor
    func testFetchUserDetailError() async {
        // Given
        let expectedError = NSError(domain: "test", code: 123, userInfo: nil)
        mockRepository.error = expectedError
        
        let expectation = XCTestExpectation(description: "Wait for fetchUserDetail to complete")
        
        // When
        viewModel.fetchUserDetail()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertTrue(self.mockNavigation.didShowAlert)
            XCTAssertTrue(self.mockNavigation.didRetryAction)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    @MainActor
    func testFetchUserDetailNetworkError() async {
        // Given
        let expectedError = TxResponseError(errorType: .network(.noNetworkConnection))
        var alertErrorNetworkConnectionCalled = false
        var retried = false
        mockRepository.error = expectedError
        mockApiClient.alertErrorNetworkConnection = { networkError, onAlertNetworkAction in
            alertErrorNetworkConnectionCalled = true
            if retried {
                onAlertNetworkAction(.cancel)
            } else {
                onAlertNetworkAction(.retry)
                retried = true
            }
        }
        
        let expectation = XCTestExpectation(description: "Wait for fetchUserDetail to complete")
        
        // When
        viewModel.fetchUserDetail()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertTrue(alertErrorNetworkConnectionCalled)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    @MainActor
    func testGoBack() {
        // When
        viewModel.goBack()
        
        // Then
        XCTAssertTrue(mockNavigation.didGoBack)
    }
    
} 
