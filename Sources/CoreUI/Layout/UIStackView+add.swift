import UIKit

public extension UIStackView {
    /// NB: not all LayoutAnchors would work for arranged subview (e.g. .leading or .top would have no meaning inside stack view
    /// but .height() and similar should work correctly
    @discardableResult
    func addArrangedSubview(_ subview: UIView, _ anchors: LayoutAnchor...) -> UIStackView {
        return addArrangedSubview(subview, anchors)
    }

    @discardableResult
    func addArrangedSubview(_ subview: UIView, _ anchors: [LayoutAnchor]) -> UIStackView {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(subview)
        subview.activate(anchors, parent: self)
        return self
    }
}
