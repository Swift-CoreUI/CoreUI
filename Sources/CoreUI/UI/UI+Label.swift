import UIKit

// swiftlint:disable identifier_name type_body_length
// swiftlint:disable:next type_name
public extension UI {

    static func Label(_ text: String? = nil,
                      font: UIFont, color: UIColor,
                      numberOfLines: Int = 1,
                      textAlignment: NSTextAlignment = .left,
                      lineBreakMode: NSLineBreakMode = .byTruncatingTail,
                      minWidth: CGFloat? = nil,
                      minHeight: CGFloat? = nil,
                      accessibility accessibilitySettings: [AccessibilitySetting] = [],
                      apply: ((UILabel) -> Void)? = nil
    ) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        label.textColor = color
        label.numberOfLines = numberOfLines
        label.lineBreakMode = lineBreakMode
        label.textAlignment = textAlignment
        label.adjustsFontForContentSizeCategory = true

        if let text = text {
            label.text = text
        }

        label.accessibility(accessibilitySettings)

        var constraints: [NSLayoutConstraint] = []

        if let width = minWidth {
            constraints.append(label.widthAnchor.constraint(greaterThanOrEqualToConstant: width))
        }

        if let height = minHeight {
            constraints.append(label.heightAnchor.constraint(greaterThanOrEqualToConstant: height))
        }

        constraints.forEach { $0.priority = defaultConstraintPriority }
        NSLayoutConstraint.activate(constraints)

        apply?(label)

        return label
    }

    static func Label(_ attributedText: NSAttributedString,
                      numberOfLines: Int = 1,
                      textAlignment: NSTextAlignment = .left,
                      lineBreakMode: NSLineBreakMode = .byTruncatingTail,
                      minWidth: CGFloat? = nil,
                      minHeight: CGFloat? = nil,
                      accessibility accessibilitySettings: [AccessibilitySetting] = [],
                      apply: ((UILabel) -> Void)? = nil
    ) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLines
        label.lineBreakMode = lineBreakMode
        label.textAlignment = textAlignment
        label.adjustsFontForContentSizeCategory = true

        label.attributedText = attributedText
        
        label.accessibility(accessibilitySettings)

        var constraints: [NSLayoutConstraint] = []

        if let width = minWidth {
            constraints.append(label.widthAnchor.constraint(greaterThanOrEqualToConstant: width))
        }

        if let height = minHeight {
            constraints.append(label.heightAnchor.constraint(greaterThanOrEqualToConstant: height))
        }

        constraints.forEach { $0.priority = defaultConstraintPriority }
        NSLayoutConstraint.activate(constraints)

        apply?(label)

        return label
    }

}
// swiftlint:enable identifier_name type_body_length
