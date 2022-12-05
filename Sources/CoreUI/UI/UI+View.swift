import UIKit

// swiftlint:disable identifier_name type_body_length
// swiftlint:disable:next type_name
public extension UI {

    static func View<ViewType: UIView>(backgroundColor: UIColor? = nil,
                                       width: CGFloat? = nil,
                                       height: CGFloat? = nil,
                                       minWidth: CGFloat? = nil,
                                       minHeight: CGFloat? = nil,
                                       cornerRadius: CGFloat? = nil,
                                       _ subviews: [UIView?],
                                       apply: ((ViewType) -> Void)? = nil
    ) -> ViewType {
        let view = ViewType(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false

        if let backgroundColor = backgroundColor {
            view.backgroundColor = backgroundColor
        }

        if let cornerRadius = cornerRadius {
            view.layer.cornerRadius = cornerRadius
        }

        for subview in subviews {
            guard let subview = subview else { continue }
            view.addSubview(subview)
        }

        var constraints: [NSLayoutConstraint] = []

        if let width = width {
            constraints.append(view.widthAnchor.constraint(equalToConstant: width))
        }

        if let height = height {
            constraints.append(view.heightAnchor.constraint(equalToConstant: height))
        }

        if let minWidth = minWidth {
            constraints.append(view.widthAnchor.constraint(greaterThanOrEqualToConstant: minWidth))
        }

        if let minHeight = minHeight {
            constraints.append(view.heightAnchor.constraint(greaterThanOrEqualToConstant: minHeight))
        }

        constraints.forEach { $0.priority = defaultConstraintPriority }
        NSLayoutConstraint.activate(constraints)

        apply?(view)

        return view
    }

    static func View<ViewType: UIView>(backgroundColor: UIColor? = nil,
                                       width: CGFloat? = nil,
                                       height: CGFloat? = nil,
                                       minWidth: CGFloat? = nil,
                                       minHeight: CGFloat? = nil,
                                       cornerRadius: CGFloat? = nil,
                                       _ subviews: UIView?...,
                                       apply: ((ViewType) -> Void)? = nil
    ) -> ViewType {
        View(backgroundColor: backgroundColor,
             width: width,
             height: height,
             minWidth: minWidth,
             minHeight: minHeight,
             cornerRadius: cornerRadius,
             subviews,
             apply: apply)
    }

    /**
     adds only one subview, but with anchors
     */
    static func View<ViewType: UIView>(backgroundColor: UIColor? = nil,
                                       width: CGFloat? = nil,
                                       height: CGFloat? = nil,
                                       minHeight: CGFloat? = nil,
                                       cornerRadius: CGFloat? = nil,
                                       _ subview: UIView,
                                       _ anchors: LayoutAnchor...,
                                       apply: ((ViewType) -> Void)? = nil
    ) -> ViewType {
        View(backgroundColor: backgroundColor, width: width, height: height, minHeight: minHeight, cornerRadius: cornerRadius, subview, anchors, apply: apply)
    }

    static func View<ViewType: UIView>(backgroundColor: UIColor? = nil,
                                       width: CGFloat? = nil,
                                       height: CGFloat? = nil,
                                       minHeight: CGFloat? = nil,
                                       cornerRadius: CGFloat? = nil,
                                       _ subview: UIView,
                                       _ anchors: [LayoutAnchor],
                                       apply: ((ViewType) -> Void)? = nil
    ) -> ViewType {
        let view = View(backgroundColor: backgroundColor, width: width, height: height, minHeight: minHeight, cornerRadius: cornerRadius) as ViewType
        view.addSubview(subview, anchors)
        apply?(view)
        return view
    }

    /// to semantically separate content views from spacers
    static func Spacer(width: CGFloat? = nil,
                       height: CGFloat? = nil,
                       minWidth: CGFloat? = nil,
                       minHeight: CGFloat? = nil) -> UIView {
        View(backgroundColor: .clear, width: width, height: height, minWidth: minWidth, minHeight: minHeight)
    }

    static func Control(backgroundColor: UIColor? = nil,
                        width: CGFloat? = nil,
                        height: CGFloat? = nil,
                        _ subviews: [UIView],
                        apply: ((UIControl) -> Void)? = nil
    ) -> UIControl {
        View(backgroundColor: backgroundColor, width: width, height: height, subviews, apply: apply)
    }

    static func Control(backgroundColor: UIColor? = nil,
                        width: CGFloat? = nil,
                        height: CGFloat? = nil,
                        _ subviews: UIView...,
                        apply: ((UIControl) -> Void)? = nil
    ) -> UIControl {
        View(backgroundColor: backgroundColor, width: width, height: height, subviews, apply: apply)
    }

}
// swiftlint:enable identifier_name type_body_length
