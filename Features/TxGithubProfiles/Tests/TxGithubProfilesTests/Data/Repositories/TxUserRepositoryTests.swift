import XCTest
import Combine
@testable import TxGithubProfiles
import TxGithubUserManagerInterface

class TxUserRepositoryTests: XCTestCase {
    var mockRemoteDataSource: TxMockGithubUserManagerInterface!
    var repository: TxUserRepositoryImpl!
    
    override func setUp() {
        super.setUp()
        mockRemoteDataSource = TxMockGithubUserManagerInterface()
        repository = TxUserRepositoryImpl(remoteDataSource: mockRemoteDataSource)
    }
    
    override func tearDown() {
        mockRemoteDataSource = nil
        repository = nil
        super.tearDown()
    }
    
    @MainActor
    func testGetUsersSuccess() async throws {
        // Given
        let mockDTO1 = TxGithubUserDTO(
            login: "testuser1",
            id: 1,
            node_id: "node1",
            avatar_url: "https://example.com/avatar1.png",
            gravatar_id: nil,
            url: "https://api.github.com/users/testuser1",
            html_url: "https://example.com/user1",
            followers_url: nil,
            following_url: nil,
            gists_url: nil,
            starred_url: nil,
            subscriptions_url: nil,
            organizations_url: nil,
            repos_url: nil,
            events_url: nil,
            received_events_url: nil,
            site_admin: false,
            name: "Test User 1",
            company: nil,
            blog: nil,
            location: nil,
            email: nil,
            bio: nil,
            twitter_username: nil,
            public_repos: nil,
            public_gists: nil,
            followers: nil,
            following: nil
        )
        
        let mockDTO2 = TxGithubUserDTO(
            login: "testuser2",
            id: 2,
            node_id: "node2",
            avatar_url: "https://example.com/avatar2.png",
            gravatar_id: nil,
            url: "https://api.github.com/users/testuser2",
            html_url: "https://example.com/user2",
            followers_url: nil,
            following_url: nil,
            gists_url: nil,
            starred_url: nil,
            subscriptions_url: nil,
            organizations_url: nil,
            repos_url: nil,
            events_url: nil,
            received_events_url: nil,
            site_admin: false,
            name: "Test User 2",
            company: nil,
            blog: nil,
            location: nil,
            email: nil,
            bio: nil,
            twitter_username: nil,
            public_repos: nil,
            public_gists: nil,
            followers: nil,
            following: nil
        )
        mockRemoteDataSource.users = [mockDTO1, mockDTO2]
        
        // When
        let result = try await repository.getUsers(since: 0, pageSize: 10)
        
        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].id, 1)
        XCTAssertEqual(result[0].username, "testuser1")
        XCTAssertEqual(result[1].id, 2)
        XCTAssertEqual(result[1].username, "testuser2")
    }
    
    @MainActor
    func testGetUsersError() async {
        // Given
        let expectedError = NSError(domain: "test", code: 123, userInfo: nil)
        mockRemoteDataSource.error = expectedError
        
        // When / Then
        do {
            _ = try await repository.getUsers(since: 0, pageSize: 10)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual((error as NSError).domain, expectedError.domain)
            XCTAssertEqual((error as NSError).code, expectedError.code)
        }
    }
    
    @MainActor
    func testGetUserDetailSuccess() async throws {
        // Given
        let mockDTO = TxGithubUserDTO(
            login: "testuser3",
            id: 3,
            node_id: nil,
            avatar_url: "https://example.com/avatar3.png",
            gravatar_id: nil,
            url: "https://api.github.com/users/testuser2",
            html_url: "https://example.com/user3",
            followers_url: nil,
            following_url: nil,
            gists_url: nil,
            starred_url: nil,
            subscriptions_url: nil,
            organizations_url: nil,
            repos_url: nil,
            events_url: nil,
            received_events_url: nil,
            site_admin: false,
            name: "Test User 3",
            company: nil,
            blog: "https://example.com/blog3",
            location: "Test Location 3",
            email: nil,
            bio: nil,
            twitter_username: nil,
            public_repos: nil,
            public_gists: nil,
            followers: 300,
            following: 150
        )
        mockRemoteDataSource.userDetails = ["testuser3": mockDTO]
        
        // When
        let result = try await repository.getUserDetail(loginUsername: "testuser3")
        
        // Then
        XCTAssertEqual(result.id, 3)
        XCTAssertEqual(result.name, "Test User 3")
        XCTAssertEqual(result.username, "testuser3")
        XCTAssertEqual(result.avatarUrl, "https://example.com/avatar3.png")
        XCTAssertEqual(result.landingPageUrl, "https://example.com/user3")
        XCTAssertEqual(result.location, "Test Location 3")
        XCTAssertEqual(result.followers, 300)
        XCTAssertEqual(result.following, 150)
        XCTAssertEqual(result.blogUrl, "https://example.com/blog3")
    }
    
    @MainActor
    func testGetUserDetailError() async {
        // Given
        let expectedError = NSError(domain: "test", code: 123, userInfo: nil)
        mockRemoteDataSource.error = expectedError
        
        // When / Then
        do {
            _ = try await repository.getUserDetail(loginUsername: "nonexistent")
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual((error as NSError).domain, expectedError.domain)
            XCTAssertEqual((error as NSError).code, expectedError.code)
        }
    }
} 
