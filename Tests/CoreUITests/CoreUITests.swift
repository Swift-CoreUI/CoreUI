import XCTest
@testable import CoreUI

final class CoreUITests: XCTestCase {
    func testVStack() {
        XCTAssertTrue(UI.VStack().isKind(of: UIStackView.self))
    }

    func testApply() {
        let v = UIView(frame: .zero).apply { $0.backgroundColor = .yellow }
        XCTAssertEqual(v.backgroundColor, UIColor.yellow)
    }

    func testWrapper() {
        XCTAssertFalse(
            UI.Wrap(
                UI.VStack(),
                padding: 10, backgroundColor: .red
            ).isKind(of: UIStackView.self)
        )
    }
}
