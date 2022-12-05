import UIKit

// swiftlint:disable identifier_name type_body_length
// swiftlint:disable:next type_name
public extension UI {

    /// Wraps view in another UIView with padding
    /// useful for building arranged subviews for UIStackView
    @inlinable
    static func Wrap<V: UIView>(_ view: UIView,
                                padding: CGFloat = 0,
                                backgroundColor: UIColor = .clear,
                                apply: ((UIView) -> Void)? = nil
    ) -> V {
        Wrap(view,
             top: padding,
             left: padding,
             bottom: padding,
             right: padding,
             backgroundColor: backgroundColor,
             apply: apply
        )
    }

    static func Wrap<V: UIView>(_ view: UIView,
                                top: CGFloat = 0,
                                left: CGFloat = 0,
                                bottom: CGFloat = 0,
                                right: CGFloat = 0,
                                backgroundColor: UIColor = .clear,
                                apply: ((UIView) -> Void)? = nil
    ) -> V {
        let wrapper = View(backgroundColor: backgroundColor, view) as V

        view.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            view.topAnchor.constraint(equalTo: wrapper.topAnchor, constant: top),
            view.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: left),
            view.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: -bottom),
            view.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -right),
        ]

        constraints.forEach { $0.priority = defaultConstraintPriority }
        NSLayoutConstraint.activate(constraints)

        apply?(wrapper)

        return wrapper
    }

}
// swiftlint:enable identifier_name type_body_length
