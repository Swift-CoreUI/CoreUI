import UIKit

public extension UIEdgeInsets {

    static func horizontal(_ const: CGFloat) -> Self {
        Self(top: 0, left: const, bottom: 0, right: const)
    }

    static func vertical(_ const: CGFloat) -> Self {
        Self(top: const, left: 0, bottom: const, right: 0)
    }

    static func top(_ const: CGFloat) -> Self {
        Self(top: const, left: 0, bottom: 0, right: 0)
    }

    static func left(_ const: CGFloat) -> Self {
        Self(top: 0, left: const, bottom: 0, right: 0)
    }

    static func bottom(_ const: CGFloat) -> Self {
        Self(top: 0, left: 0, bottom: const, right: 0)
    }

    static func right(_ const: CGFloat) -> Self {
        Self(top: 0, left: 0, bottom: 0, right: const)
    }

    static func all(_ const: CGFloat) -> Self {
        Self(top: const, left: const, bottom: const, right: const)
    }

    /// Creates UIEdgeInsets with left and right insets set to `horizontal`. Top and bottom insets are set to zero.
    /// - Parameter horizontal: value for `left` and `right` insets
    /// - Returns: UIEdgeInsets instance
    init(horizontal: CGFloat) {
        self = Self(top: 0, left: horizontal, bottom: 0, right: horizontal)
    }

    /// Creates UIEdgeInsets with top and bottom insets set to `vertical`. Left and right insets are set to zero.
    /// - Parameter vertical: value for `top` and `bottom` insets
    /// - Returns: UIEdgeInsets instance
    init(vertical: CGFloat) {
        self = Self(top: vertical, left: 0, bottom: vertical, right: 0)
    }

    /// Creates UIEdgeInsets with top and bottom insets set to `vertical`, left and right insets set to `horizontal`.
    /// - Parameter horizontal: value for `left` and `right` insets
    /// - Parameter vertical: value for `top` and `bottom` insets
    /// - Returns: UIEdgeInsets instance
    init(horizontal: CGFloat, vertical: CGFloat) {
        self = Self(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    /// Creates UIEdgeInsets with all insets set to the same value.
    /// - parameter all: value for `left`, `right`, `top` and `bottom` insets
    /// - Returns: UIEdgeInsets instance
    init(_ all: CGFloat) {
        self = Self(top: all, left: all, bottom: all, right: all)
    }

    /// - Returns: sum of `left` and `right` insets
    var horizontalInsets: CGFloat {
        return left + right
    }

    /// - Returns: sum of `top` and `bottom` insets
    var verticalInsets: CGFloat {
        return top + bottom
    }
}
