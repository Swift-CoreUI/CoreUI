import UIKit

// idea from https://www.swiftbysundell.com/articles/using-child-view-controllers-as-plugins-in-swift/
public extension UIViewController {

    @discardableResult
    func add(_ child: UIViewController, into v: UIView? = nil, _ anchors: LayoutAnchor...) -> Self {
        return add(child, into: v, anchors)
    }

    @discardableResult
    func add(_ child: UIViewController, into v: UIView? = nil, _ anchors: [LayoutAnchor]) -> Self {
        child.remove() // just in case
        addChild(child)

        let targetView = v ?? view

        if anchors.count > 0 {
            targetView?.addSubview(child.view, anchors)
        } else {
            targetView?.addSubview(child.view)
        }
        child.didMove(toParent: self)

        return self
    }

    func add(_ child: UIViewController, into v: UIView? = nil, padding: CGFloat) {
        add(child, into: v,
            .leading(padding), .top(padding), .trailing(-padding), .bottom(-padding))
    }

    func remove() {
        guard parent != nil else { return }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }

    @discardableResult
    func attach(to parent: UIViewController?, into v: UIView? = nil, _ anchors: LayoutAnchor...) -> Self {
        return attach(to: parent, into: v, anchors)
    }

    @discardableResult
    func attach(to parent: UIViewController?, into v: UIView? = nil, _ anchors: [LayoutAnchor]) -> Self {
        parent?.add(self, into: v, anchors)
        return self
    }

    @discardableResult
    func attach(to parent: UIViewController?, into v: UIView? = nil, padding: CGFloat) -> Self {
        return attach(to: parent, into: v, .leading(padding), .top(padding), .trailing(-padding), .bottom(-padding))
    }

    func detach() {
        remove()
    }

    // idea from: https://davedelong.com/blog/2017/11/06/a-better-mvc-part-2-fixing-encapsulation/
    func transition(to child: UIViewController, animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        let duration = animated ? 0.3 : 0.0

        let current = children.last
        addChild(child)

        child.view.translatesAutoresizingMaskIntoConstraints = true
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        child.view.frame = view.bounds

        if let existing = current {
            existing.willMove(toParent: nil)

            transition(from: existing, to: child, duration: duration, options: [.transitionCrossDissolve], animations: {}, completion: { done in
                existing.removeFromParent()
                child.didMove(toParent: self)
                completion?(done)
            })

        } else {
            view.addSubview(child.view)

            UIView.animate(withDuration: duration, delay: 0, options: [.transitionCrossDissolve], animations: {}, completion: { done in
                child.didMove(toParent: self)
                completion?(done)
            })
        }
    }
}
