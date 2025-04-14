import XCTest
import Combine
@testable import TxGithubProfiles
import Resolver
import TxApiClient
import TxLocalization
import TxNetworkModels

class TxUserListViewModelTests: XCTestCase {
    var mockRepository: TxMockUserRepository!
    var mockNavigation: TxMockGithubProfileNavigation!
    var mockApiClient: TxMockApiClient!
    var mockGetUsersUseCase: TxGetUsersUseCaseImpl!
    var viewModel: TxUserListViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        Resolver.register { L10n() }.scope(ResolverScope.application)
        mockRepository = TxMockUserRepository()
        mockNavigation = TxMockGithubProfileNavigation()
        mockApiClient = TxMockApiClient()
        
            // Register mock dependencies in Resolver
        Resolver.register { self.mockRepository as TxUserRepository }
        Resolver.register { self.mockNavigation as TxGithubProfileNavigation }
        Resolver.register { self.mockApiClient as TxApiClientProtocol }
        
        mockGetUsersUseCase = TxGetUsersUseCaseImpl()
        Resolver.register { self.mockGetUsersUseCase as TxGetUsersUseCase }
        
        viewModel = TxUserListViewModel()
        cancellables = []
    }
    
    override func tearDown() {
        mockRepository.error = nil
        mockRepository = nil
        mockNavigation = nil
        mockApiClient = nil
        mockGetUsersUseCase = nil
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testInitialState() {
            // Then
        XCTAssertEqual(viewModel.userListState, .loading)
        XCTAssertTrue(viewModel.users.isEmpty)
        XCTAssertFalse(viewModel.hasData)
        XCTAssertFalse(viewModel.hasMoreData)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    @MainActor
    func testLoadInitialUsersSuccess() async {
            // Given
        let expectedUsers = TxTestData.testUsers
        mockRepository.users = expectedUsers
        
            // Create expectation for state change
        let expectation = expectation(description: "State should change to data")
        var receivedState: TxUserListViewModel.UserListState?
        
        viewModel.$userListState
            .dropFirst() // Skip initial .loading state
            .sink { state in
                receivedState = state
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
            // When
        viewModel.loadInitialUsers()
        
            // Then
        await fulfillment(of: [expectation], timeout: 1.0)
        
        if case .data(let users) = receivedState {
            XCTAssertEqual(users.count, expectedUsers.count)
            XCTAssertEqual(users[0].id, expectedUsers[0].id)
            XCTAssertEqual(users[1].id, expectedUsers[1].id)
        }
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.hasMoreData)
    }
    
    @MainActor
    func testLoadInitialUsersError() async {
            // Given
        let expectedError = TxResponseError(errorType: .unknown)
        var alertErrorNetworkCommonCalled = false
        var retried = false
        mockRepository.error = expectedError
        mockApiClient.alertErrorNetworkCommon = { networkError, onAlertNetworkAction in
            alertErrorNetworkCommonCalled = true
            if retried {
                onAlertNetworkAction(.cancel)
            } else {
                onAlertNetworkAction(.retry)
                retried = true
            }
        }
        
        let expectation = XCTestExpectation(description: "Wait for loadInitialUsers to complete expect error")
        
            // When
        viewModel.loadInitialUsers()
        viewModel.loadInitialUsers()
            // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertFalse(self.viewModel.hasMoreData)
            XCTAssertTrue(alertErrorNetworkCommonCalled)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    @MainActor
    func testLoadInitialUsersErrorUnknow() async {
            // Given
        let expectedError = NSError(domain: "test", code: 123, userInfo: nil)
        mockRepository.error = expectedError
        let mockNavigationCaptured = self.mockNavigation!
        
        let expectation = XCTestExpectation(description: "Wait for loadInitialUsers to complete")
            // When
        viewModel.loadInitialUsers()
            // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                //            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertFalse(self.viewModel.hasMoreData)
            XCTAssertTrue(mockNavigationCaptured.didShowAlert)
            XCTAssertTrue(mockNavigationCaptured.didRetryAction)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    @MainActor
    func test_loadMoreData_whenIsLoadingTrue_shouldNotLoadMore() async {
            // Given
        viewModel.isLoading = true
        
            // When
        viewModel.loadMoreData()
        
            // Then
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(mockRepository.getUsersCallCount, 0)
    }
    
    @MainActor
    func test_loadMoreData_whenHasMoreDataFalse_shouldNotLoadMore() async {
            // Given
        viewModel.hasMoreData = false
        
            // When
        viewModel.loadMoreData()
        
            // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(mockRepository.getUsersCallCount, 0)
    }
    
    @MainActor
    func test_loadMoreData_whenSuccess_shouldUpdateState() async {
            // Given
        viewModel.isLoading = false
        viewModel.hasMoreData = true
        let expectedUsers = TxTestData.testUsers
        mockRepository.users = expectedUsers
        let expectation = XCTestExpectation(description: "Wait for loadMoreData to complete")
        var receivedState: TxUserListViewModel.UserListState?
        
        viewModel.$userListState
            .dropFirst() // Skip initial .loading state
            .sink { state in
                receivedState = state
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
            // When
        viewModel.loadMoreData()
        
        await fulfillment(of: [expectation], timeout: 1.0)
        
        if case .data(let users) = receivedState {
            XCTAssertEqual(users.count, 2)
            XCTAssertEqual(users[0].loginUsername, "testuser1")
            XCTAssertEqual(users[1].loginUsername, "testuser2")
        }
        
        XCTAssertFalse(self.viewModel.isLoading)
        XCTAssertFalse(self.viewModel.hasMoreData)
        XCTAssertEqual(self.viewModel.lastestUserId, 2)
    }
    
    @MainActor
    func test_loadMoreData_whenError_shouldShowAlert() async {
            // Given
        viewModel.isLoading = false
        viewModel.hasMoreData = true
        mockRepository.error = NSError(domain: "test", code: 123, userInfo: nil)
        let expectation = XCTestExpectation(description: "Wait for loadMoreData to complete")
        
            // When
        viewModel.loadMoreData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                // Then
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertFalse(self.viewModel.hasMoreData)
            XCTAssertTrue(self.mockNavigation.didShowAlert)
            XCTAssertTrue(self.mockNavigation.didRetryAction)
            expectation.fulfill()

        }
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    @MainActor
    func test_loadMoreData_whenError_shouldShow_network_error() async {
            // Given
        viewModel.isLoading = false
        viewModel.hasMoreData = true
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
        
        let expectation = XCTestExpectation(description: "Wait for loadMoreData to complete expect error")
        
            // When
        viewModel.loadMoreData()
            // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertTrue(alertErrorNetworkConnectionCalled)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    @MainActor
    func testGotoDetail() async {
            // When
        viewModel.gotoDetail(loginUsername: "testuser")
        
            // Then
        XCTAssertTrue(mockNavigation.didRouteToUserDetail)
        XCTAssertEqual(mockNavigation.userDetailLoginUsername, "testuser")
    }
}
