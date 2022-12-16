import UIKit

public extension UIView {
    func accessibility(_ settings: [UI.AccessibilitySetting]) {
        for setting in settings {
            setting.apply(to: self)
        }
    }

    func accessibility(_ settings: UI.AccessibilitySetting...) {
        accessibility(settings)
    }
}
