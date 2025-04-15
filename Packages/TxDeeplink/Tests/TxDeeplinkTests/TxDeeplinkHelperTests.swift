import XCTest
@testable import TxDeeplink

final class TxDeeplinkHelperTests: XCTestCase {
    func testMakeUrlWithPathAndParams() {
        let path = "/test"
        let params: [String: Any?] = ["key1": "value1", "key2": nil]
        let url = TxDeeplinkHelper.makeUrl(path: path, params: params)
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.scheme, TxDeeplinkHelper.APP_SCHEMA)
        XCTAssertEqual(url?.host, TxDeeplinkHelper.APP_HOST)
        XCTAssertEqual(url?.path, path)
        XCTAssertEqual(url?.query, "key1=value1")
    }
    
    func testMakeUrlFromString() {
        let string = "https://example.com/test"
        let url = TxDeeplinkHelper.makeUrl(from: string)
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.scheme, TxDeeplinkHelper.APP_SCHEMA)
        XCTAssertEqual(url?.host, TxDeeplinkHelper.APP_HOST)
    }
    
    func testMakeDeeplinkWithEnumType() {
        enum TestEnum: String {
            case testPath = "/test"
        }
        let params: [String: Any?] = ["key1": "value1"]
        let url = TxDeeplinkHelper.makeDeeplink(type: TestEnum.testPath, params: params)
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.scheme, TxDeeplinkHelper.APP_SCHEMA)
        XCTAssertEqual(url?.host, TxDeeplinkHelper.APP_HOST)
        XCTAssertEqual(url?.path, TestEnum.testPath.rawValue)
        XCTAssertEqual(url?.query, "key1=value1")
    }
}
