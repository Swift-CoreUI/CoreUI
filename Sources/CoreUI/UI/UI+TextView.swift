import UIKit

// swiftlint:disable identifier_name type_body_length
// swiftlint:disable:next type_name
public extension UI {
    
    static func TextView(_ attributedText: NSAttributedString? = nil,
                         _ text: String? = nil,
                         font: UIFont? = nil,
                         textColor: UIColor? = nil,
                         linkTextAttributes: [NSAttributedString.Key: Any]? = nil,
                         apply: ((UITextView) -> Void)? = nil
    ) -> UITextView {
        let textView = UITextView()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.adjustsFontForContentSizeCategory = true
        
        textView.textContainer.lineFragmentPadding = 0 // making padding the same as in UILabel
        textView.textContainerInset = .zero
        
        textView.backgroundColor = .clear
        
        if let linkTextAttributes = linkTextAttributes {
            textView.linkTextAttributes = linkTextAttributes
        }
        
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = false // to make links tapable isSelectable should be true!
        
        if let attributedText = attributedText {
            textView.attributedText = attributedText
        } else if let text = text {
            textView.text = text
        }
        
        if let font = font {
            textView.font = font
        }
        
        if let textColor = textColor {
            textView.textColor = textColor
        }
        
        apply?(textView)
        
        return textView
    }
    
}
// swiftlint:enable identifier_name type_body_length
