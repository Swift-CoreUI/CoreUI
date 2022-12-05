import UIKit

public extension UIView {
    /**
     Activates `LayoutAnchor`s on `self`.
     Automatially sets `translatesAutoresizingMaskIntoConstraints` to `false`.
     ```
     let myView = UIView()
     addSubview(myView)
     myView.activate(.top(0), .bottom(0), .leading(0), .trailing(0))
     ```
     */
    func activate(_ anchors: LayoutAnchor...) {
        activate(anchors)
    }

    func activate(_ anchors: [LayoutAnchor], parent: UIView? = nil) {
        let parent = parent ?? self.superview

        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            anchors.map { [unowned self] anchor in anchor.asConstraint(for: self, parentView: parent) }
        )
    }
}

public extension UILayoutGuide {
    /**
     Activates `LayoutAnchor`s on `self`.
     ```
     let myGuide = UILayoutGuide()
     addLayoutGuide(myGuide)
     myGuide.activate(.top(0), .bottom(0), .leading(0), .trailing(0))
     ```
     */
    func activate(_ anchors: LayoutAnchor...) {
        activate(anchors)
    }

    func activate(_ anchors: [LayoutAnchor], parent: UIView? = nil) {
        guard let parent = parent ?? self.owningView else {
            fatalError("UILayoutGuide should be added to some view first")
        }

        NSLayoutConstraint.activate(
            anchors.map { [unowned self] anchor in anchor.asConstraint(for: self, parentView: parent) }
        )
    }

}

/// Idea for this DSL came from https://gist.github.com/V8tr/3d28b3468bb60b02c5134d8d6ad78c43
public enum LayoutAnchor {
    case constant(
        attribute: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation,
        constant: CGFloat,
        priority: UILayoutPriority
    )

    case relative(
        attribute: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation,
        toAttribute: NSLayoutConstraint.Attribute,
        constant: CGFloat,
        multiplier: CGFloat,
        priority: UILayoutPriority
    )

    case relativeToSafeArea(
        attribute: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation,
        toAttribute: NSLayoutConstraint.Attribute,
        constant: CGFloat,
        multiplier: CGFloat,
        priority: UILayoutPriority
    )

    case relativeTo(
        otherView: Any,
        attribute: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation,
        toAttribute: NSLayoutConstraint.Attribute,
        constant: CGFloat,
        multiplier: CGFloat,
        priority: UILayoutPriority
    )

}

/// Public API
public extension LayoutAnchor {
    /// Common cases
    /// NB: Those static let are functions!
    static func leading(_ const: CGFloat) -> Self { relation(.leading, is: .equal, to: .leading)(const) }
    static let minLeading = relation(.leading, is: .greaterThanOrEqual, to: .leading)
    static let maxLeading = relation(.leading, is: .lessThanOrEqual, to: .leading)

    static func trailing(_ const: CGFloat) -> Self { relation(.trailing, is: .equal, to: .trailing)(const) }
    static let minTrailing = relation(.trailing, is: .greaterThanOrEqual, to: .trailing)
    static let maxTrailing = relation(.trailing, is: .lessThanOrEqual, to: .trailing)

    static func top(_ const: CGFloat) -> Self { relation(.top, is: .equal, to: .top)(const) }
    static func top(_ relation: NSLayoutConstraint.Relation, _ const: CGFloat = 0) -> Self {
        c(.top, is: relation, with: const)
    }
    static func top(is relation: NSLayoutConstraint.Relation = .equal,
                    to otherView: UIView? = nil,
                    _ toAttribute: NSLayoutConstraint.Attribute = .top,
                    with const: CGFloat) -> Self {
        c(.top, is: relation, to: otherView, toAttribute, with: const)
    }
    static let minTop = relation(.top, is: .greaterThanOrEqual, to: .top)
    static let minTopLow = relation(.top, is: .greaterThanOrEqual, to: .top, priority: .defaultLow)
    static let maxTop = relation(.top, is: .lessThanOrEqual, to: .top)

    static func bottom(_ const: CGFloat) -> Self { relation(.bottom, is: .equal, to: .bottom)(const) }
    static func bottom(_ relation: NSLayoutConstraint.Relation, _ const: CGFloat = 0) -> Self {
        .c(.bottom, is: relation, with: const)
    }
    static let minBottom = relation(.bottom, is: .greaterThanOrEqual, to: .bottom)
    static let minBottomLow = relation(.bottom, is: .greaterThanOrEqual, to: .bottom, priority: .defaultLow)
    static let maxBottom = relation(.bottom, is: .lessThanOrEqual, to: .bottom)

    static func centerX(_ const: CGFloat) -> Self { relation(.centerX, is: .equal, to: .centerX)(const) }

    static func centerY(_ const: CGFloat) -> Self { relation(.centerY, is: .equal, to: .centerY)(const) }

    static let width = constant(.width, is: .equal)
    static let minWidth = constant(.width, is: .greaterThanOrEqual)
    static let maxWidth = constant(.width, is: .lessThanOrEqual)

    static let height = constant(.height, is: .equal)
    static let minHeight = constant(.height, is: .greaterThanOrEqual)
    static let maxHeight = constant(.height, is: .lessThanOrEqual)

    /// safe area anchors
    static let safeTop = relationToSafeArea(.top, is: .equal, to: .top)
    static let safeMinTop = relationToSafeArea(.top, is: .greaterThanOrEqual, to: .top)
    static let safeMinTopLow = relationToSafeArea(.top, is: .greaterThanOrEqual, to: .top, priority: .defaultLow)
    static let safeMaxTop = relationToSafeArea(.top, is: .lessThanOrEqual, to: .top)

    static func safeBottom(_ const: CGFloat, priority: UILayoutPriority = .required) -> Self {
        relationToSafeArea(.bottom, is: .equal, to: .bottom, priority: priority)(const)
    }
    static let safeMinBottom = relationToSafeArea(.bottom, is: .greaterThanOrEqual, to: .bottom)
    static let safeMinBottomLow = relationToSafeArea(.bottom, is: .greaterThanOrEqual, to: .bottom, priority: .defaultLow)
    static let safeMaxBottom = relationToSafeArea(.bottom, is: .lessThanOrEqual, to: .bottom)
    static let safeMaxBottomLow = relationToSafeArea(.bottom, is: .lessThanOrEqual, to: .bottom, priority: .defaultLow)

    static let safeLeading = relationToSafeArea(.leading, is: .equal, to: .leading)

    static let safeTrailing = relationToSafeArea(.trailing, is: .equal, to: .trailing)

    /// general purpose anchor generator
    /// Examples: ```
    /// containerView.addSubview(UIView(),
    ///     .c(.leading), // equivalent to `.leading(0)` or .c(.leading, to: containerView, .leading, with: 0)
    ///     .c(.top, with: 10),
    ///     .c(.bottom, is: .greaterThanOrEqualTo, .bottom)
    ///     .c(.trailing, is: .equal, to: someOtherViewOnTheRight, .leading, with: -20)
    ///     .c(.bottom, priority: .defaultLow)
    /// )
    /// ```
    static func c(
        _ attribute: NSLayoutConstraint.Attribute,
        is relation: NSLayoutConstraint.Relation = .equal,
        to otherView: Any? = nil,
        _ toAttribute: NSLayoutConstraint.Attribute? = nil,
        with constant: CGFloat = 0,
        priority: UILayoutPriority = .required,
        multiplier: CGFloat = 1
    ) -> Self {
        otherView != nil
            ? .relativeTo(otherView: otherView!,
                          attribute: attribute,
                          relation: relation,
                          toAttribute: toAttribute ?? attribute,
                          constant: constant,
                          multiplier: multiplier,
                          priority: priority)
            : .relative(attribute: attribute,
                        relation: relation,
                        toAttribute: toAttribute ?? attribute,
                        constant: constant,
                        multiplier: multiplier,
                        priority: priority)
    }

}

extension LayoutAnchor {
    // internal functional builders & helpers
    private static func constant(
        _ attribute: NSLayoutConstraint.Attribute,
        is relation: NSLayoutConstraint.Relation,
        priority: UILayoutPriority = .required
    ) -> ((CGFloat) -> Self) {
        return { constant in
            return .constant(
                attribute: attribute,
                relation: relation,
                constant: constant,
                priority: priority
            )
        }
    }

    private static func relation(
        _ attribute: NSLayoutConstraint.Attribute,
        is relation: NSLayoutConstraint.Relation,
        to toAttribute: NSLayoutConstraint.Attribute,
        withMultiplier multiplier: CGFloat = 1,
        priority: UILayoutPriority = .required
    ) -> ((CGFloat) -> Self) {
        return { constant in
            return .relative(
                attribute: attribute,
                relation: relation,
                toAttribute: toAttribute,
                constant: constant,
                multiplier: multiplier,
                priority: priority
            )
        }
    }

    private static func relationToSafeArea(
        _ attribute: NSLayoutConstraint.Attribute,
        is relation: NSLayoutConstraint.Relation,
        to toAttribute: NSLayoutConstraint.Attribute,
        withMultiplier multiplier: CGFloat = 1,
        priority: UILayoutPriority = .required
    ) -> ((CGFloat) -> Self) {
        return { constant in
            return .relativeToSafeArea(
                attribute: attribute,
                relation: relation,
                toAttribute: toAttribute,
                constant: constant,
                multiplier: multiplier,
                priority: priority
            )
        }
    }

//    private static func relationToOtherView(
//        _ attribute: NSLayoutConstraint.Attribute,
//        is relation: NSLayoutConstraint.Relation,
//        to toAttribute: NSLayoutConstraint.Attribute,
//        withMultiplier multiplier: CGFloat = 1
//    ) -> ((Any, CGFloat) -> Self) {
//        return { otherView, constant in
//            return .relativeTo(
//                otherView: otherView,
//                attribute: attribute,
//                relation: relation,
//                toAttribute: toAttribute,
//                constant: constant,
//                multiplier: multiplier,
//                priority: .required
//            )
//        }
//    }
//
//    private static func relationToOtherViewWithAttribute(
//        _ attribute: NSLayoutConstraint.Attribute,
//        is relation: NSLayoutConstraint.Relation,
//        withMultiplier multiplier: CGFloat = 1
//    ) -> ((Any, NSLayoutConstraint.Attribute, CGFloat) -> Self) {
//        return { otherView, toAttribute, constant in
//            return .relativeTo(
//                otherView: otherView,
//                attribute: attribute,
//                relation: relation,
//                toAttribute: toAttribute,
//                constant: constant,
//                multiplier: multiplier,
//                priority: .required
//            )
//        }
//    }

}

internal extension LayoutAnchor {
    fileprivate func asConstraint(for subview: Any, parentView: UIView?) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint

        switch self {
        case .constant(let attribute, let relation, let constant, let priority):
            constraint = NSLayoutConstraint(
                item: subview,
                attribute: attribute,
                relatedBy: relation,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 0, // or 1?
                constant: constant
            )
            constraint.priority = priority
        case .relative(let attribute, let relation, let toAttribute, let constant, let multiplier, let priority):
            constraint = NSLayoutConstraint(
                item: subview,
                attribute: attribute,
                relatedBy: relation,
                toItem: parentView,
                attribute: toAttribute,
                multiplier: multiplier,
                constant: constant
            )
            constraint.priority = priority
        case .relativeToSafeArea(let attribute, let relation, let toAttribute, let constant, let multiplier, let priority):
            constraint = NSLayoutConstraint(
                item: subview,
                attribute: attribute,
                relatedBy: relation,
                toItem: parentView?.safeAreaLayoutGuide,
                attribute: toAttribute,
                multiplier: multiplier,
                constant: constant
            )
            constraint.priority = priority
        case .relativeTo(let otherView, let attribute, let relation, let toAttribute, let constant, let multiplier, let priority):
            constraint = NSLayoutConstraint(
                item: subview,
                attribute: attribute,
                relatedBy: relation,
                toItem: otherView,
                attribute: toAttribute,
                multiplier: multiplier,
                constant: constant
            )
            constraint.priority = priority
        }

        return constraint
    }
}

