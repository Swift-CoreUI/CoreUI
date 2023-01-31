import UIKit

public extension UIView {
    func animateWithKeyboardNotification(_ notification: Notification, animations: (() -> Void)? = nil) {
        // default animation triggers animations for NSLayoutConstraints changes
        let animations = animations ?? { [weak self] in self?.layoutIfNeeded() }
        let animator = Self.animatorFromKeyboardNotification(notification, animations: animations)

        animator?.startAnimation()
    }

    static func animatorFromKeyboardNotification(_ notification: Notification, animations: @escaping () -> Void) -> UIViewPropertyAnimator? {
        guard
            // extract the duration of the keyboard animation
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            // extract the animation curve of the keyboard animation
            let curveValue = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int,
            let curve = UIView.AnimationCurve(rawValue: curveValue)
        else { return nil }

        return UIViewPropertyAnimator(duration: duration, curve: curve, animations: animations)
    }
}
