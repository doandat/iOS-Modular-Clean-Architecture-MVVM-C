import XCTest
import Moya
@testable import TxGithubUserManagerInterface
@testable import TxGithubUserManagerService
@testable import TxNetworkModels

final class TxGithubUserManagerServiceTests: XCTestCase {
    var sut: TxGithubUserManagerService!
    var mockProvider: MoyaProvider<TxGithubUserManagerService.Target>!
    
    override func setUp() {
        super.setUp()
        let baseURL = URL(string: "https://api.github.com")!
        mockProvider = MoyaProvider<TxGithubUserManagerService.Target>(
            endpointClosure: { target in
                let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
                return defaultEndpoint
            },
            stubClosure: MoyaProvider.immediatelyStub
        )
        sut = TxGithubUserManagerService(baseURL: baseURL, moyaProvider: mockProvider)
    }
    
    override func tearDown() {
        sut = nil
        mockProvider = nil
        super.tearDown()
    }

    @MainActor
    func testGetUsers_WhenSuccessful_ReturnsUsers() async throws {
        // Given
        let usersJSON = """
        [
            {
                "login": "user1",
                "id": 1,
                "avatar_url": "https://example.com/avatar1"
            },
            {
                "login": "user2",
                "id": 2,
                "avatar_url": "https://example.com/avatar2"
            }
        ]
        """
        let mockProvider = MoyaProvider<TxGithubUserManagerService.Target>(
            endpointClosure: { target in
                return Endpoint(
                    url: URL(string: "https://api.github.com/users")!.absoluteString,
                    sampleResponseClosure: { .networkResponse(200, usersJSON.data(using: .utf8)!) },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers
                )
            },
            stubClosure: MoyaProvider.immediatelyStub
        )
        sut = TxGithubUserManagerService(
            baseURL: URL(string: "https://api.github.com")!,
            moyaProvider: mockProvider
        )
        
        // When
        let users = try await sut.getUsers(since: 0, pageSize: 2)
        
        // Then
        XCTAssertEqual(users.count, 2)
        XCTAssertEqual(users[0].login, "user1")
        XCTAssertEqual(users[0].id, 1)
        XCTAssertEqual(users[0].avatar_url, "https://example.com/avatar1")
    }

    @MainActor
    func testGetUserDetail_WhenSuccessful_ReturnsUserDetail() async throws {
        // Given
        let userJSON = """
        {
            "login": "testuser",
            "id": 1,
            "avatar_url": "https://example.com/avatar"
        }
        """
        
        let mockProvider = MoyaProvider<TxGithubUserManagerService.Target>(
            endpointClosure: { target in
                return Endpoint(
                    url: URL(string: "https://api.github.com/users/testuser")!.absoluteString,
                    sampleResponseClosure: { .networkResponse(200, userJSON.data(using: .utf8)!) },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers
                )
            },
            stubClosure: MoyaProvider.immediatelyStub
        )
        sut = TxGithubUserManagerService(
            baseURL: URL(string: "https://api.github.com")!,
            moyaProvider: mockProvider
        )

        // When
        let user = try await sut.getUserDetail(loginUsername: "testuser")
        
        // Then
        XCTAssertEqual(user.login, "testuser")
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.avatar_url, "https://example.com/avatar")
    }

    @MainActor
    func testGetUsers_WhenFailed_ThrowsError() async {
        // Given
        let errorProvider = MoyaProvider<TxGithubUserManagerService.Target>(
            endpointClosure: { target in
                return Endpoint(
                    url: URL(string: "https://api.github.com/users")!.absoluteString,
                    sampleResponseClosure: { .networkResponse(500, Data()) },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers
                )
            },
            stubClosure: MoyaProvider.immediatelyStub
        )
        sut = TxGithubUserManagerService(
            baseURL: URL(string: "https://api.github.com")!,
            moyaProvider: errorProvider
        )
        
        // When/Then
        do {
            _ = try await sut.getUsers(since: 0, pageSize: 10)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    @MainActor
    func testGetUserDetail_WhenFailed_ThrowsError() async {
        // Given
        let errorProvider = MoyaProvider<TxGithubUserManagerService.Target>(
            endpointClosure: { target in
                return Endpoint(
                    url: URL(string: "https://api.github.com/users/testuser")!.absoluteString,
                    sampleResponseClosure: { .networkResponse(500, Data()) },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers
                )
            },
            stubClosure: MoyaProvider.immediatelyStub
        )
        sut = TxGithubUserManagerService(
            baseURL: URL(string: "https://api.github.com")!,
            moyaProvider: errorProvider
        )
        
        // When/Then
        do {
            _ = try await sut.getUserDetail(loginUsername: "testuser")
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertNotNil(error)
        }
    }
} 
