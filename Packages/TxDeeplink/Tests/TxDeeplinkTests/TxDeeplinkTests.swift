import XCTest
@testable import TxDeeplink

final class TxDeeplinkTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
}

final class TxDeeplinkCoordinatorTests: XCTestCase {
    @MainActor
    func testHandleURL() {
        let mockHandler = MockHandler()
        let coordinator = TxDeeplinkCoordinator(handlers: [mockHandler])
        let url = URL(string: "https://example.com")!
        
        let result = coordinator.handleURL(url)
        
        XCTAssertTrue(result)
        XCTAssertTrue(mockHandler.openURLCalled)
    }
    
    func testCanOpenURL() {
        let mockHandler = MockHandler()
        let coordinator = TxDeeplinkCoordinator(handlers: [mockHandler])
        let url = URL(string: "https://example.com")!
        
        let result = coordinator.canOpenURL(url)
        
        XCTAssertTrue(result)
        XCTAssertTrue(mockHandler.canOpenURLCalled)
    }
}
