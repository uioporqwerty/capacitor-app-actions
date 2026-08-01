import XCTest
@testable import AppActionsPlugin

class AppActionsTests: XCTestCase {
    func testActionModel() {
        let action = AppAction(id: "search", title: "Search", subtitle: "Find things", icon: "magnifyingglass")

        XCTAssertEqual(action.id, "search")
        XCTAssertEqual(action.title, "Search")
        XCTAssertEqual(action.subtitle, "Find things")
        XCTAssertEqual(action.icon, "magnifyingglass")
    }
}
