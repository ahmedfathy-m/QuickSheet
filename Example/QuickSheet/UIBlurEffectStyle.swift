//
//  UIBlurEffectStyle.swift
//  QuickSheet_Example
//
//  Created by Ahmed Fathy on 08/01/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

extension UIBlurEffect.Style: CaseIterable, CustomStringConvertible {
    public static var allCases: [UIBlurEffect.Style] {
        return [
            .regular,
            .light,
            .extraLight,
            .dark,
            .prominent,
            
            .systemUltraThinMaterial,
            .systemThinMaterial,
            .systemMaterial,
            .systemThickMaterial,
            .systemChromeMaterial,
            
            .systemUltraThinMaterialDark,
            .systemThinMaterialDark,
            .systemMaterialDark,
            .systemThickMaterialDark,
            .systemChromeMaterialDark,
            
            .systemUltraThinMaterialLight,
            .systemThinMaterialLight,
            .systemMaterialLight,
            .systemThickMaterialLight,
            .systemChromeMaterialLight,
        ]
    }
    
    public var description: String {
        switch self {
            
        case .extraLight:
            return "Extra Light"
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        case .regular:
            return "Regular"
        case .prominent:
            return "Prominent"
        case .systemUltraThinMaterial:
            return "Ultra Thin Material"
        case .systemThinMaterial:
            return "Thin Material"
        case .systemMaterial:
            return "Material"
        case .systemThickMaterial:
            return "Thick Material"
        case .systemChromeMaterial:
            return "Chrome Material"
        case .systemUltraThinMaterialLight:
            return "Ultra Thin Material Light"
        case .systemThinMaterialLight:
            return "Thin Material Light"
        case .systemMaterialLight:
            return "Material Light"
        case .systemThickMaterialLight:
            return "Thick Material Light"
        case .systemChromeMaterialLight:
            return "Chrome Material Light"
        case .systemUltraThinMaterialDark:
            return "Ultra Thin Material Dark"
        case .systemThinMaterialDark:
            return "Thin Material Dark"
        case .systemMaterialDark:
            return "Material Dark"
        case .systemThickMaterialDark:
            return "Thick Material Dark"
        case .systemChromeMaterialDark:
            return "Chrome Material Dark"
        }
    }
}

