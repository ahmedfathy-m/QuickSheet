//
//  Preferences.swift
//  QuickSheet_Example
//
//  Created by Ahmed Fathy on 08/01/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

enum Preferences: CaseIterable {
    // MARK: - Keys
    case fraction
    case scrollable
    case expandable
    case blurEffect
    case cornerRadius
    case shadowRadius
    case shadowOpacity
    
    // MARK: - Prferences
    static var values: [Preferences: Any] = [
        .fraction : 0.3,
        .blurEffect : UIBlurEffect.Style.regular,
        .scrollable: true,
        .expandable: true,
        .cornerRadius: CGFloat(5.0),
        .shadowRadius: CGFloat(10.0),
        .shadowOpacity: Float(0.1)
    ]
}

extension Preferences: CustomStringConvertible {
    var description: String {
        switch self {
        case .fraction:
            return "Fraction"
        case .scrollable:
            return "Is Scrollable"
        case .expandable:
            return "Is Expandable"
        case .blurEffect:
            return "Blur Effect"
        case .cornerRadius:
            return "Corner Radius"
        case .shadowRadius:
            return "Shadow Radius"
        case .shadowOpacity:
            return "Shadow Opacity"
        }
    }
}
