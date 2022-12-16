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

    func testAccessibility() {
        let accID = "Identifier"
        let accLabel = "Label"
        let accHint = "Hint"
        let accValue = "Value"

        let accessibilitySettings: [UI.AccessibilitySetting] = [
            .isElement(true),
            .identifier(accID),
            .label(accLabel),
            .hint(accHint),
            .value(accValue),
            .traits(.button),
            .containerType(.list),
            .elements([]),
            .elementsHidden(true),
            .shouldGroupChildren(true),
        ]

        let v = UI.View()

        XCTAssertEqual(v.isAccessibilityElement, false)
        XCTAssertNil(v.accessibilityIdentifier)
        XCTAssertNil(v.accessibilityLabel)
        XCTAssertNil(v.accessibilityHint)
        XCTAssertNil(v.accessibilityValue)
        XCTAssertEqual(v.accessibilityTraits, UIAccessibilityTraits.none)
        XCTAssertNil(v.accessibilityElements)
        XCTAssertEqual(v.accessibilityElementsHidden, false)
        XCTAssertEqual(v.shouldGroupAccessibilityChildren, false)

        v.accessibility(accessibilitySettings)

        XCTAssertEqual(v.isAccessibilityElement, true)
        XCTAssertEqual(v.accessibilityIdentifier, accID)
        XCTAssertEqual(v.accessibilityLabel, accLabel)
        XCTAssertEqual(v.accessibilityHint, accHint)
        XCTAssertEqual(v.accessibilityValue, accValue)
        XCTAssertEqual(v.accessibilityTraits, UIAccessibilityTraits.button)
        XCTAssertNotNil(v.accessibilityElements)
        XCTAssertEqual(v.accessibilityElementsHidden, true)
        XCTAssertEqual(v.shouldGroupAccessibilityChildren, true)


    }

    func testPreconfiguredAccessiblityForButton() {
        let buttonText = "Button"

        let b = UI.Button(buttonText)

        XCTAssertEqual(b.isAccessibilityElement, true)
        XCTAssertEqual(b.shouldGroupAccessibilityChildren, true)
        XCTAssertEqual(b.accessibilityTraits, .button)
        XCTAssertEqual(b.accessibilityLabel, buttonText)

        let v = UI.View()

        XCTAssertEqual(v.isAccessibilityElement, false)
        XCTAssertEqual(v.shouldGroupAccessibilityChildren, false)
        XCTAssertEqual(v.accessibilityTraits, .none)
        XCTAssertNil(v.accessibilityLabel)
    }
}
