import XCTest
@testable import TxDeeplink

final class TxDeeplinkPathGithubProfileTests: XCTestCase {
    func testInitWithValidListURL() {
        let url = URL(string: "gitadmin-app://com.tx/githubProfile/list")!
        let profile = TxDeeplinkPath.GithubProfile(url: url)
        
        XCTAssertNotNil(profile)
        XCTAssertEqual(profile, .list)
    }
    
    func testInitWithValidDetailURL() {
        let url = URL(string: "gitadmin-app://com.tx/githubProfile/detail")!
        let profile = TxDeeplinkPath.GithubProfile(url: url)
        
        XCTAssertNotNil(profile)
        XCTAssertEqual(profile, .detail)
    }
    
    func testInitWithInvalidURL() {
        let url = URL(string: "gitadmin-app://com.tx/invalid/path")!
        let profile = TxDeeplinkPath.GithubProfile(url: url)
        
        XCTAssertNil(profile)
    }
}
