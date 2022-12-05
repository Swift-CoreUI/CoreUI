import UIKit

// swiftlint:disable identifier_name type_body_length
// swiftlint:disable:next type_name
public extension UI {

    /// - Parameter verticalAnchors: should not contain horizontal anchors! leading, trailing and width anchors will be added automatically
    @inlinable
    static func VScrollView(backgroundColor: UIColor? = nil,
                            width: CGFloat? = nil,
                            height: CGFloat? = nil,
                            minHeight: CGFloat? = nil,
                            contentInset: UIEdgeInsets = .zero,
                            _ subview: UIView,
                            _ verticalAnchors: LayoutAnchor...,
                            apply: ((UIScrollView) -> Void)? = nil
    ) -> UIScrollView {
        subview.translatesAutoresizingMaskIntoConstraints = false

        let scrollView = View(backgroundColor: backgroundColor, width: width, height: height, minHeight: minHeight) as UIScrollView
        scrollView.contentInset = contentInset

        scrollView.addSubview(
            subview,
            .leading(0),
            .trailing(0),
            // automatically adding common anchor which is useful for vertical scroll (could be .c(.width) or .centerX(0)):
            .c(.width, with: -(contentInset.left + contentInset.right))
        )

        if verticalAnchors.isEmpty {
            // if there are no additional anchors adding default case (pinning to the top and the bottom)
            subview.activate(.top(0), .bottom(0))
        } else {
            subview.activate(verticalAnchors)
        }

        apply?(scrollView)

        return scrollView
    }

    /// - Parameter horizontalAnchors: should not contain vertical anchors! top, bottom and height anchors will be added automatically 
    @inlinable
    static func HScrollView(backgroundColor: UIColor? = nil,
                            width: CGFloat? = nil,
                            height: CGFloat? = nil,
                            minHeight: CGFloat? = nil,
                            contentInset: UIEdgeInsets = .zero,
                            _ subview: UIView,
                            _ horizontalAnchors: LayoutAnchor...,
                            apply: ((UIScrollView) -> Void)? = nil
    ) -> UIScrollView {
        subview.translatesAutoresizingMaskIntoConstraints = false

        let scrollView = View(backgroundColor: backgroundColor, width: width, height: height, minHeight: minHeight) as UIScrollView
        scrollView.contentInset = contentInset

        scrollView.addSubview(
            subview,
            .top(0),
            .bottom(0),
            // automatically adding common anchor which is useful for horizontal scroll (could be .c(.height) or .centerY(0)):
            .c(.height, with: -(contentInset.top + contentInset.bottom))
        )

        if horizontalAnchors.isEmpty {
            // if there are no additional anchors adding default case (pinning to the top and the bottom)
            subview.activate(.leading(0), .trailing(0))
        } else {
            subview.activate(horizontalAnchors)
        }

        apply?(scrollView)

        return scrollView
    }

    static func ScrollView(backgroundColor: UIColor? = nil,
                           width: CGFloat? = nil,
                           height: CGFloat? = nil,
                           minHeight: CGFloat? = nil,
                           _ subview: UIView,
                           _ anchors: LayoutAnchor...,
                           apply: ((UIScrollView) -> Void)? = nil
    ) -> UIScrollView {
        View(backgroundColor: backgroundColor, width: width, height: height, minHeight: minHeight, subview, anchors, apply: apply)
    }

}
// swiftlint:enable identifier_name type_body_length
