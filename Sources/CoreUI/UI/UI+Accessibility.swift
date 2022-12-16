import UIKit

public extension UI {
    enum AccessibilitySetting {
        case isElement(Bool)
        case identifier(String)
        case label(String)
        case hint(String)
        case value(String)
        case traits(UIAccessibilityTraits)
        case containerType(UIAccessibilityContainerType)
        case elements([Any])
        case elementsHidden(Bool)
        case shouldGroupChildren(Bool)
    }
}

internal extension UI.AccessibilitySetting {
    func apply(to view: UIView) {
        switch self {
        case .isElement(let isElement):
            view.isAccessibilityElement = isElement
        case .identifier(let identifier):
            view.accessibilityIdentifier = identifier
        case .label(let label):
            view.accessibilityLabel = label
        case .hint(let hint):
            view.accessibilityHint = hint
        case .value(let value):
            view.accessibilityValue = value
        case .traits(let traits):
            view.accessibilityTraits = traits
        case .containerType(let type):
            view.accessibilityContainerType = type
        case .elementsHidden(let isHidden):
            view.accessibilityElementsHidden = isHidden
        case .elements(let elements):
            view.accessibilityElements = elements
        case .shouldGroupChildren(let shouldGroup):
            view.shouldGroupAccessibilityChildren = shouldGroup
        }
    }
}

