//
//  QuickSheetOptions.swift
//  QuickSheets
//
//  Created by Ahmed Fathy on 04/01/2023.
//

import UIKit

/// Handles the visual properties of the sheet pop-up
public struct QuickSheetOptions {
    let fraction: Double
    lazy internal var minHeight: CGFloat = fraction * UIScreen.main.bounds.height
    internal let maxHeight: CGFloat = 0.9 * UIScreen.main.bounds.height
    public let cornerRadius: CGFloat
    public let presentationStyle: PresentationStyle
    public let shadowStyle: ShadowStyle
    public let blurEffect: UIBlurEffect.Style?
    
    /// Initializes the QuickSheet Options
    /// - Parameters:
    ///   - fraction: The sheet's height reperesented as a fraction of the screen height.
    ///   - presentationStyle: The sheet's presentation style; regular, expandable or scrollable.
    ///   - cornerRadius: The sheet's corner radius.
    ///   - blurEffect: The sheet's background blur effect. Setting this to nil replaces the blur with a 75% opaque black background.
    ///   - shadowStyle: The sheet's shadow properties.
    public init(fraction: Double,
                presentationStyle: PresentationStyle = QuickSheetOptions.standard.presentationStyle,
                cornerRadius: CGFloat = QuickSheetOptions.standard.cornerRadius,
                blurEffect: UIBlurEffect.Style? = QuickSheetOptions.standard.blurEffect,
                shadowStyle: ShadowStyle = QuickSheetOptions.standard.shadowStyle) {
        self.fraction = fraction
        self.cornerRadius = cornerRadius
        self.blurEffect = blurEffect
        self.presentationStyle = fraction > 0.8 ? .regular : presentationStyle
        self.shadowStyle = shadowStyle
    }
    
    /// The standard Quicksheet options (can be modified from the app delegate)
    public static var standard = QuickSheetOptions(fraction: 0.3, presentationStyle: .expandable, cornerRadius: 5, blurEffect: .systemChromeMaterialLight, shadowStyle: .standard)
    /// The standard options with height set at 50% and scrolling enabled
    public static let scrollableHalf = QuickSheetOptions(fraction: 0.5, presentationStyle: .scrollable)
    /// The standard options with height set at 50% and no scrolling or expandability
    public static let staticHalf = QuickSheetOptions(fraction: 0.5, presentationStyle: .regular)

    /// Handle the layer shadow properties of the sheet
    public struct ShadowStyle {
        let shadowRadius: CGFloat
        let shadowColor: UIColor
        let shadowOpacity: Float
        
        public init(shadowRadius: CGFloat, shadowColor: UIColor, shadowOpacity: Float) {
            self.shadowOpacity = shadowOpacity
            self.shadowColor = shadowColor
            self.shadowRadius = shadowRadius
        }
        
        /// The standard shadow configuration
        public static let standard = ShadowStyle(shadowRadius: 15, shadowColor: .black, shadowOpacity: 0.15)
    }

}
