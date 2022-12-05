import UIKit

// swiftlint:disable identifier_name type_body_length
// swiftlint:disable:next type_name
public extension UI {

    static func ImageView(named imageName: String? = nil,
                          image: UIImage? = nil,
                          tintColor: UIColor? = nil,
                          width: CGFloat? = nil,
                          height: CGFloat? = nil,
                          minHeight: CGFloat? = nil,
                          cornerRadius: CGFloat? = nil,
                          contentMode: UIView.ContentMode = .scaleAspectFill,
                          clipsToBounds: Bool = true,
                          apply: ((UIImageView) -> Void)? = nil
    ) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.contentMode = contentMode
        imageView.clipsToBounds = clipsToBounds

        if let imageName = imageName {
            imageView.image = UIImage(named: imageName)
        } else if let image = image {
            imageView.image = image
        }

        let isForceImageAspect = imageView.contentMode == .scaleAspectFill || imageView.contentMode == .scaleAspectFit

        if isForceImageAspect, let currImg = imageView.image {
            // adding constraints to keep image aspect ratio (with low priority)
            let height = currImg.size.height
            let width = currImg.size.width

            // can use UILayoutPriority(rawValue: 249) instead of UILayoutPriority.fitting
            imageView.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
            imageView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
            imageView.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
            imageView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .vertical)

            let constraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: height/width)
            constraint.priority = .defaultLow
            constraint.isActive = true
        }

        if let tintColor = tintColor {
            imageView.tintColor = tintColor
        }

        if let cornerRadius = cornerRadius {
            imageView.layer.cornerRadius = cornerRadius
        }

        var constraints: [NSLayoutConstraint] = []

        if let width = width {
            constraints.append(imageView.widthAnchor.constraint(equalToConstant: width))
        }

        if let height = height {
            constraints.append(imageView.heightAnchor.constraint(equalToConstant: height))
        }

        if let minHeight = minHeight {
            constraints.append(imageView.heightAnchor.constraint(greaterThanOrEqualToConstant: minHeight))
        }

        constraints.forEach { $0.priority = defaultConstraintPriority }
        NSLayoutConstraint.activate(constraints)

        apply?(imageView)

        return imageView
    }

}
// swiftlint:enable identifier_name type_body_length
