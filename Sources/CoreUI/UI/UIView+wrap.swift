import UIKit

public extension UIView {

    @inlinable func wrap<V: UIView>(
        _ padding: CGFloat = 0,
        as: V.Type = V.self, // to use .wrap(as: UIControl.self) instead .wrap() as UIControl
        backgroundColor: UIColor = .clear
    ) -> V {
        UI.Wrap(self, padding: padding, backgroundColor: backgroundColor) as V
    }

    @inlinable func wrap<V: UIView>(
        top: CGFloat = 0,
        left: CGFloat = 0,
        bottom: CGFloat = 0,
        right: CGFloat = 0,
        backgroundColor: UIColor = .clear
    ) -> V {
        UI.Wrap(self, top: top, left: left, bottom: bottom, right: right, backgroundColor: backgroundColor) as V
    }
}
