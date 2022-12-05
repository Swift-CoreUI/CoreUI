import UIKit

public extension UIView {
    /**
     Adds `subview` to `self` with constraints using layout anchors.
     Automatially sets `translatesAutoresizingMaskIntoConstraints` to `false`.
     Supported anchors can be extended.
     Usage: ```
        containerView.addSubview(UIView(),
            .leading(10), .trailing(-10), .top(10), .bottom(-10), .width(100), .height(50)
        )
     ```
     */
    @discardableResult
    func addSubview(_ subview: UIView, _ anchors: [LayoutAnchor]) -> UIView {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        subview.activate(anchors, parent: self)
        return self
    }

    @discardableResult
    func addSubview(_ subview: UIView, _ anchors: LayoutAnchor...) -> UIView {
        return addSubview(subview, anchors)
    }

    @discardableResult
    func addSubview(_ subview: UIView, padding: CGFloat) -> UIView {
        return addSubview(subview, .top(padding), .leading(padding), .bottom(-padding), .trailing(-padding))
    }

    /**
     Adds `layoutGuide` to `self` with constraints using layout anchors.
     Supported anchors can be extended.
     Usage: ```
        let myGuide = UILayoutGuide()
        containerView.addLayoutGuide(myGuide,
            .leading(10), .trailing(-10), .top(10), .bottom(-10), .width(100), .height(50)
        )
     ```
     */
    @discardableResult
    func addLayoutGuide(_ layoutGuide: UILayoutGuide, _ anchors: [LayoutAnchor]) -> UIView {
        addLayoutGuide(layoutGuide)
        layoutGuide.activate(anchors)
        return self
    }

    @discardableResult
    func addLayoutGuide(_ layoutGuide: UILayoutGuide, _ anchors: LayoutAnchor...) -> UIView {
        return addLayoutGuide(layoutGuide, anchors)
    }

    @discardableResult
    func addLayoutGuide(_ layoutGuide: UILayoutGuide, padding: CGFloat) -> UIView {
        return addLayoutGuide(layoutGuide, .top(padding), .leading(padding), .bottom(-padding), .trailing(-padding))
    }
}
