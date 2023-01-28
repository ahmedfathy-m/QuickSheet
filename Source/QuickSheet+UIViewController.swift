//
//  QuickSheet+UIViewController.swift
//  QuickSheets
//
//  Created by Ahmed Fathy on 07/01/2023.
//

import UIKit

extension UIViewController {
    /// Present a view as a bottom sheet with custom QuickSheetOptions object
    /// - Parameters:
    ///   - viewController: The target view controller you're trying to present.
    ///   - options: The custom options object that determines the visual properties and customisations for the presented bottom sheet.
    public func presentQuickSheet(_ viewController: UIViewController, options: QuickSheetOptions) {
        let wrapper = QuickSheetWrapper()
        wrapper.childViewController = viewController
        wrapper.options = options
        wrapper.modalPresentationStyle = .custom
        self.present(wrapper, animated: false)
    }
    
    /// Present a view as a bottom sheet with the pre-defined standard options with only the fraction value changed.
    /// - Parameters:
    ///   - viewController: The target view controller you're trying to present.
    ///   - fraction: The sheet's height reperesented as a fraction of the screen height.
    public func presentQuickSheet(_ viewController: UIViewController, fraction: Double) {
        let wrapper = QuickSheetWrapper()
        let options = QuickSheetOptions(fraction: fraction)
        wrapper.childViewController = viewController
        wrapper.options = options
        wrapper.modalPresentationStyle = .custom
        self.present(wrapper, animated: false)
    }
    
    /// Present a view as a bottom sheet with the pre-defined standard options with only the fraction value and the presentation style changed.
    /// - Parameters:
    ///   - viewController: The target view controller you're trying to present.
    ///   - fraction: The sheet's height reperesented as a fraction of the screen height.
    ///   - style: The sheet's presentation style; regular, expandable or scrollable.
    public func presentQuickSheet(_ viewController: UIViewController, fraction: Double, style: PresentationStyle) {
        let wrapper = QuickSheetWrapper()
        let options = QuickSheetOptions(fraction: fraction, presentationStyle: style)
        wrapper.childViewController = viewController
        wrapper.options = options
        wrapper.modalPresentationStyle = .custom
        self.present(wrapper, animated: false)
    }
}
