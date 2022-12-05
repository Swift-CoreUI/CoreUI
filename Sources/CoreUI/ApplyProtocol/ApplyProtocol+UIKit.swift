import Foundation
import UIKit

/// Adding ApplyProtocol to some manually selected classes only (UIView, etc).
/// Do not adding ApplyProtocol to NSObject: it will be too wide.
extension UIView: ApplyProtocol {}
extension UIViewController: ApplyProtocol {}
extension NSLayoutConstraint: ApplyProtocol {}
extension UIGestureRecognizer: ApplyProtocol {}
