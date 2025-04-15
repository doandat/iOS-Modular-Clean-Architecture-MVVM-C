import XCTest
import Moya
@testable import TxGithubUserManagerService

final class TxGithubUserTargetBuilderTests: XCTestCase {
    let baseURL = URL(string: "https://api.github.com")!
    
    func testGetUsersTarget() {
        // Given
        let since = 10
        let pageSize = 20
        let target = TxGithubUserTargetBuilder(
            operation: .getUsers(since: since, pageSize: pageSize),
            baseURL: baseURL
        )
        
        // Then
        XCTAssertEqual(target.method, .get)
        XCTAssertEqual(target.path, "/users")
        
        if case let .requestParameters(parameters, encoding) = target.task {
            XCTAssertEqual(parameters["since"] as? Int, since)
            XCTAssertEqual(parameters["per_page"] as? Int, pageSize)
            XCTAssertTrue(encoding is URLEncoding)
        } else {
            XCTFail("Expected requestParameters task")
        }
    }
    
    func testGetUserDetailTarget() {
        // Given
        let username = "testuser"
        let target = TxGithubUserTargetBuilder(
            operation: .getUserDetail(loginUsername: username),
            baseURL: baseURL
        )
        
        // Then
        XCTAssertEqual(target.method, .get)
        XCTAssertEqual(target.path, "/users/\(username)")
        
        if case .requestPlain = target.task {
            // Success
        } else {
            XCTFail("Expected requestPlain task")
        }
    }
    
    func testHeaders() {
        // Given
        let target = TxGithubUserTargetBuilder(
            operation: .getUsers(since: 0, pageSize: 10),
            baseURL: baseURL
        )
        
        // Then
        XCTAssertEqual(target.headers?["Content-Type"], "application/json")
    }
    
    func testBaseURL() {
        // Given
        let target = TxGithubUserTargetBuilder(
            operation: .getUsers(since: 0, pageSize: 10),
            baseURL: baseURL
        )
        
        // Then
        XCTAssertEqual(target.baseURL, baseURL)
    }
} 
