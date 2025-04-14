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
    
    @MainActor
    func testUserDetailStateEquality() async {
        // Given
        let user1 = TxUserDetailUIModel(
            baseInfo: TxUserBaseInfoUIModel(
                id: 1,
                loginUsername: "user1",
                avatarUrl: "url1"
            ),
            name: "User 1",
            company: "Company 1",
            blog: "blog1.com",
            location: "Location 1",
            email: "user1@test.com",
            bio: "Bio 1",
            publicRepos: 10,
            publicGists: 5,
            followers: 100,
            following: 50,
            createdAt: "2020-01-01",
            updatedAt: "2020-01-01"
        )
        
        let user2 = TxUserDetailUIModel(
            baseInfo: TxUserBaseInfoUIModel(
                id: 2,
                loginUsername: "user2",
                avatarUrl: "url2"
            ),
            name: "User 2",
            company: "Company 2",
            blog: "blog2.com",
            location: "Location 2",
            email: "user2@test.com",
            bio: "Bio 2",
            publicRepos: 20,
            publicGists: 10,
            followers: 200,
            following: 100,
            createdAt: "2020-01-02",
            updatedAt: "2020-01-02"
        )
        
        // When & Then
        XCTAssertEqual(user1, user1) // Same object
        XCTAssertNotEqual(user1, user2) // Different objects
        
        // Test with different values for each property
        let user1Modified = TxUserDetailUIModel(
            baseInfo: TxUserBaseInfoUIModel(
                id: 1,
                loginUsername: "user1",
                avatarUrl: "url1"
            ),
            name: "User 1 Modified",
            company: "Company 1",
            blog: "blog1.com",
            location: "Location 1",
            email: "user1@test.com",
            bio: "Bio 1",
            publicRepos: 10,
            publicGists: 5,
            followers: 100,
            following: 50,
            createdAt: "2020-01-01",
            updatedAt: "2020-01-01"
        )
        
        XCTAssertNotEqual(user1, user1Modified)
    }
    
    @MainActor
    func testUserDetailStateUpdate() async {
        // Given
        let initialUser = TxUserDetailUIModel(
            baseInfo: TxUserBaseInfoUIModel(
                id: 1,
                loginUsername: "user1",
                avatarUrl: "url1"
            ),
            name: "User 1",
            company: "Company 1",
            blog: "blog1.com",
            location: "Location 1",
            email: "user1@test.com",
            bio: "Bio 1",
            publicRepos: 10,
            publicGists: 5,
            followers: 100,
            following: 50,
            createdAt: "2020-01-01",
            updatedAt: "2020-01-01"
        )
        
        let updatedUser = TxUserDetailUIModel(
            baseInfo: TxUserBaseInfoUIModel(
                id: 1,
                loginUsername: "user1",
                avatarUrl: "url1"
            ),
            name: "User 1 Updated",
            company: "Company 1 Updated",
            blog: "blog1-updated.com",
            location: "Location 1 Updated",
            email: "user1-updated@test.com",
            bio: "Bio 1 Updated",
            publicRepos: 20,
            publicGists: 10,
            followers: 200,
            following: 100,
            createdAt: "2020-01-01",
            updatedAt: "2020-01-01"
        )
        
        // When
        viewModel.user = initialUser
        viewModel.user = updatedUser
        
        // Then
        XCTAssertNotEqual(viewModel.user, initialUser)
        XCTAssertEqual(viewModel.user, updatedUser)
    }
} 
