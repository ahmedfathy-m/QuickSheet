//
//  QuickSheetOptions.swift
//  QuickSheets
//
//  Created by Ahmed Fathy on 04/01/2023.
//

import UIKit

/// Handles the visual properties of the sheet pop-up
public struct QuickSheetOptions {
    let blurEffect: UIBlurEffect.Style
    let fraction: Double
    lazy var minHeight: CGFloat = fraction * UIScreen.main.bounds.height
    let maxHeight: CGFloat = 0.9 * UIScreen.main.bounds.height
    let cornerRadius: CGFloat
    let isExpandable: Bool
    let isScrollable: Bool
    let shadowStyle: ShadowStyle
    
    /// Initializes the QuickSheet Options
    /// - Parameters:
    ///   - fraction: The sheet's height reperesented as a fraction of the screen height.
    ///   - isExpandable: The sheet's capability to expand to a near full screen size.
    ///   - isScrollable: Enables content scrolling in the sheet container.
    ///   - cornerRadius: The sheet's corner radius.
    ///   - blurEffect: The sheet's background blur effect.
    ///   - shadowStyle: The sheet's shadow properties.
    public init(fraction: Double, isExpandable: Bool, isScrollable: Bool, cornerRadius: CGFloat, blurEffect: UIBlurEffect.Style = .systemUltraThinMaterialDark, shadowStyle: ShadowStyle = ShadowStyle.standard) {
        self.fraction = fraction
        self.cornerRadius = cornerRadius
        self.blurEffect = blurEffect
        self.isExpandable = fraction > 0.8 ? false : isExpandable
        self.isScrollable = isScrollable
        self.shadowStyle = shadowStyle
    }
    
    /// The standard Quicksheet options
    public static let standard = QuickSheetOptions(fraction: 0.3, isExpandable: true, isScrollable: false, cornerRadius: 5)

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
