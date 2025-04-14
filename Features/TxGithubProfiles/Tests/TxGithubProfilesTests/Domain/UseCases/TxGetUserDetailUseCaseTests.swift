import XCTest
import Combine
@testable import TxGithubProfiles
import Resolver

class TxGetUserDetailUseCaseTests: XCTestCase {
    var mockRepository: TxMockUserRepository!
    var useCase: TxGetUserDetailUseCaseImpl!
    
    override func setUp() {
        super.setUp()
        mockRepository = TxMockUserRepository()
        
        // Register mock repository in Resolver
        Resolver.register { self.mockRepository as TxUserRepository }
        
        useCase = TxGetUserDetailUseCaseImpl()
    }
    
    override func tearDown() {
        mockRepository = nil
        useCase = nil
        super.tearDown()
    }
    
    @MainActor
    func testGetUserDetailSuccess() async throws {
        // Given
        let expectedUser = TxTestData.testUserDetail
        mockRepository.userDetails = ["testuser3": expectedUser]
        
        // When
        let result = try await useCase.getUserDetail(loginUsername: "testuser3")
        
        // Then
        XCTAssertEqual(result.id, expectedUser.id)
        XCTAssertEqual(result.name, expectedUser.name)
        XCTAssertEqual(result.username, expectedUser.username)
    }
    
    @MainActor
    func testGetUserDetailError() async {
        // Given
        let expectedError = NSError(domain: "test", code: 123, userInfo: nil)
        mockRepository.error = expectedError
        
        // When / Then
        do {
            _ = try await useCase.getUserDetail(loginUsername: "nonexistent")
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual((error as NSError).domain, expectedError.domain)
            XCTAssertEqual((error as NSError).code, expectedError.code)
        }
    }
    
    @MainActor
    func testGetUserDetailNotFound() async {
        // Given
        mockRepository.userDetails = [:]
        
        // When / Then
        do {
            _ = try await useCase.getUserDetail(loginUsername: "nonexistent")
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual((error as NSError).domain, "TxUserRepository")
            XCTAssertEqual((error as NSError).code, 404)
        }
    }
} 
