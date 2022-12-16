import UIKit

// swiftlint:disable identifier_name type_body_length
// swiftlint:disable:next type_name
public extension UI {

    private static func Stack(axis: NSLayoutConstraint.Axis,
                              spacing: CGFloat,
                              distribution: UIStackView.Distribution,
                              alignment: UIStackView.Alignment,
                              backgroundColor: UIColor?,
                              isInteractionEnabled: Bool?,
                              accessibility accessibilitySettings: [AccessibilitySetting],
                              _ subviews: [UIView?] = [],
                              apply: ((UIStackView) -> Void)? = nil
    ) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: subviews.compactMap { $0 })

        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = axis
        stack.distribution = distribution
        stack.alignment = alignment
        stack.spacing = spacing

        if let isInteractionEnabled = isInteractionEnabled {
            stack.isUserInteractionEnabled = isInteractionEnabled
        }

        stack.accessibility(accessibilitySettings)

        if #available(iOS 14.0, *) {
            if let backgroundColor = backgroundColor {
                stack.backgroundColor = backgroundColor
            }
        }

        apply?(stack)

        return stack
    }

    @inline(__always)
    static func HStack(spacing: CGFloat = 0,
                       distribution: UIStackView.Distribution = .fill,
                       alignment: UIStackView.Alignment = .fill,
                       backgroundColor: UIColor? = nil,
                       isInteractionEnabled: Bool? = nil,
                       accessibility: [AccessibilitySetting] = [],
                       _ subviews: [UIView?] = [],
                       apply: ((UIStackView) -> Void)? = nil
    ) -> UIStackView {
        Stack(axis: .horizontal,
              spacing: spacing,
              distribution: distribution,
              alignment: alignment,
              backgroundColor: backgroundColor,
              isInteractionEnabled: isInteractionEnabled,
              accessibility: accessibility,
              subviews,
              apply: apply
        )
    }

    @inline(__always)
    static func HStack(spacing: CGFloat = 0,
                       distribution: UIStackView.Distribution = .fill,
                       alignment: UIStackView.Alignment = .fill,
                       backgroundColor: UIColor? = nil,
                       isInteractionEnabled: Bool? = nil,
                       accessibility: [AccessibilitySetting] = [],
                       _ subviews: UIView?...,
                       apply: ((UIStackView) -> Void)? = nil
    ) -> UIStackView {
        HStack(spacing: spacing,
               distribution: distribution,
               alignment: alignment,
               backgroundColor: backgroundColor,
               isInteractionEnabled: isInteractionEnabled,
               accessibility: accessibility,
               subviews,
               apply: apply
        )
    }

    @inline(__always)
    static func VStack(spacing: CGFloat = 0,
                       distribution: UIStackView.Distribution = .fill,
                       alignment: UIStackView.Alignment = .fill,
                       backgroundColor: UIColor? = nil,
                       isInteractionEnabled: Bool? = nil,
                       accessibility: [AccessibilitySetting] = [],
                       _ subviews: [UIView?] = [],
                       apply: ((UIStackView) -> Void)? = nil
    ) -> UIStackView {
        Stack(axis: .vertical,
              spacing: spacing,
              distribution: distribution,
              alignment: alignment,
              backgroundColor: backgroundColor,
              isInteractionEnabled: isInteractionEnabled,
              accessibility: accessibility,
              subviews,
              apply: apply
        )
    }

    @inline(__always)
    static func VStack(spacing: CGFloat = 0,
                       distribution: UIStackView.Distribution = .fill,
                       alignment: UIStackView.Alignment = .fill,
                       backgroundColor: UIColor? = nil,
                       isInteractionEnabled: Bool? = nil,
                       accessibility: [AccessibilitySetting] = [],
                       _ subviews: UIView?...,
                       apply: ((UIStackView) -> Void)? = nil
    ) -> UIStackView {
        VStack(spacing: spacing,
               distribution: distribution,
               alignment: alignment,
               backgroundColor: backgroundColor,
               isInteractionEnabled: isInteractionEnabled,
               accessibility: accessibility,
               subviews,
               apply: apply
        )
    }

}
// swiftlint:enable identifier_name type_body_length
