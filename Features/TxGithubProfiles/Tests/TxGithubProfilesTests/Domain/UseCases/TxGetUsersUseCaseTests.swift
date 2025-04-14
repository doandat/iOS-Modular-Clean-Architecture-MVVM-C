import XCTest
import Combine
@testable import TxGithubProfiles
import Resolver

class TxGetUsersUseCaseTests: XCTestCase {
    var mockRepository: TxMockUserRepository!
    var useCase: TxGetUsersUseCaseImpl!
    
    override func setUp() {
        super.setUp()
        mockRepository = TxMockUserRepository()
        
        // Register mock repository in Resolver
        Resolver.register { self.mockRepository as TxUserRepository }
        
        useCase = TxGetUsersUseCaseImpl()
    }
    
    override func tearDown() {
        mockRepository = nil
        useCase = nil
        super.tearDown()
    }
    
    @MainActor
    func testGetUsersSuccess() async throws {
        // Given
        let expectedUsers = TxTestData.testUsers
        mockRepository.users = expectedUsers
        
        // When
        let result = try await useCase.getUsers(since: 0, pageSize: 10)
        
        // Then
        XCTAssertEqual(result.count, expectedUsers.count)
        XCTAssertEqual(result[0].id, expectedUsers[0].id)
        XCTAssertEqual(result[1].id, expectedUsers[1].id)
    }
    
    @MainActor
    func testGetUsersError() async {
        // Given
        let expectedError = NSError(domain: "test", code: 123, userInfo: nil)
        mockRepository.error = expectedError
        
        // When / Then
        do {
            _ = try await useCase.getUsers(since: 0, pageSize: 10)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual((error as NSError).domain, expectedError.domain)
            XCTAssertEqual((error as NSError).code, expectedError.code)
        }
    }
} 
