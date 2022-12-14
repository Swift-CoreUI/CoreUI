import UIKit

// swiftlint:disable identifier_name type_body_length
// swiftlint:disable:next type_name
public extension UI {
    
    static func Button(_ title: String? = nil,
                       font: UIFont? = nil,
                       titleColor: UIColor? = nil,
                       backgroundColor: UIColor? = nil,
                       image: UIImage? = nil,
                       tintColor: UIColor? = nil,
                       selectedTitle: String? = nil,
                       selectedImage: UIImage? = nil,
                       isSelected: Bool = false,
                       width: CGFloat? = nil,
                       height: CGFloat? = nil,
                       accessibility additionalAccessibilitySettings: [AccessibilitySetting] = [],
                       apply: ((UIButton) -> Void)? = nil
    ) -> UIButton {
        let button = View(backgroundColor: backgroundColor, width: width, height: height) as UIButton
        
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        if let title = title {
            button.setTitle(title, for: .normal)
            button.accessibility(.label(title))
        }
        
        if let image = image {
            button.setImage(image, for: .normal)
        }
        
        if let selectedTitle = selectedTitle {
            button.setTitle(selectedTitle, for: .selected)
        }
        
        if let selectedImage = selectedImage {
            button.setImage(selectedImage, for: .selected)
        }
        
        if let tintColor = tintColor {
            button.tintColor = tintColor
        }
        
        button.isSelected = isSelected

        button.accessibility(.isElement(true), .shouldGroupChildren(true), .traits(.button))
        button.accessibility(additionalAccessibilitySettings)

        apply?(button)
        
        return button
    }
    
    static func Button(_ attributedTitle: NSAttributedString,
                       backgroundColor: UIColor? = nil,
                       image: UIImage? = nil,
                       selectedAttributedTitle: NSAttributedString? = nil,
                       selectedImage: UIImage? = nil,
                       isSelected: Bool = false,
                       width: CGFloat? = nil,
                       height: CGFloat? = nil,
                       accessibility additionalAccessibilitySettings: [AccessibilitySetting] = [],
                       apply: ((UIButton) -> Void)? = nil
    ) -> UIButton {
        let button = View(backgroundColor: backgroundColor, width: width, height: height) as UIButton
        
        button.setAttributedTitle(attributedTitle, for: .normal)

        if let image = image {
            button.setImage(image, for: .normal)
        }
        
        if let selectedAttributedTitle = selectedAttributedTitle {
            button.setAttributedTitle(selectedAttributedTitle, for: .selected)
        }
        
        if let selectedImage = selectedImage {
            button.setImage(selectedImage, for: .selected)
        }
        
        button.isSelected = isSelected
        
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true

        button.accessibility(.isElement(true), .shouldGroupChildren(true), .traits(.button), .label(attributedTitle.string))
        button.accessibility(additionalAccessibilitySettings)

        apply?(button)

        return button
    }
    
}
// swiftlint:enable identifier_name type_body_length
