import XCTest
@testable import CoreUI

final class ApplyProtocolTests: XCTestCase {
    private class AClass: ApplyProtocol {
        var intProperty: Int
        init(intProperty: Int) {
            self.intProperty = intProperty
        }
    }

    func testApply() {
        let anInstance = AClass(intProperty: 1).apply { $0.intProperty = 2 }

        XCTAssertEqual(anInstance.intProperty, 2)

        anInstance.apply { $0.intProperty = 3 }

        XCTAssertEqual(anInstance.intProperty, 3)
    }

    func testLet() {
        let anInstance = AClass(intProperty: 1)

        let val = anInstance.let { $0.intProperty + 10 }

        XCTAssertEqual(val, 11)
    }

    func testOptionalLet() {
        var anInstance: AClass? = nil

        let val1 = anInstance?.let { _ in return 5 }
        XCTAssertNil(val1)

        anInstance = AClass(intProperty: 1)
        XCTAssertEqual(anInstance?.intProperty, 1)

        let val2 = anInstance?.let { _ in return 10 }
        XCTAssertEqual(val2, 10)
    }
}
