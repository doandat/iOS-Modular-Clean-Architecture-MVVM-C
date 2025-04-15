import XCTest
@testable import TxFoundation

final class TxFoundationTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
}

final class URLExtensionsTests: XCTestCase {

    func testMakeUrlWithValidPathAndParams() {
        let path = "/test"
        let params: [String: Any?] = ["key1": "value1", "key2": "value2"]
        let url = URL.makeUrl(path: path, params: params)
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.path, path)
        XCTAssertEqual(url?.query, "key1=value1&key2=value2")
    }
    
    func testMakeUrlWithEmptyParams() {
        let path = "/test"
        let url = URL.makeUrl(path: path, params: [:])
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.path, path)
        XCTAssertEqual(url?.query, "")
    }
    
    func testParseQueryParameters() {
        let url = URL(string: "https://example.com/test?key1=value1&key2=value2")!
        let params = url.parseQueryParameters()
        
        XCTAssertEqual(params["key1"], "value1")
        XCTAssertEqual(params["key2"], "value2")
    }
    
    func testParseQueryParametersWithNoParams() {
        let url = URL(string: "https://example.com/test")!
        let params = url.parseQueryParameters()
        
        XCTAssertTrue(params.isEmpty)
    }
}
