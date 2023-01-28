//
//  PresentationStyle.swift
//  QuickSheet
//
//  Created by Ahmed Fathy on 27/01/2023.
//

import Foundation

/// Determines how the sheet is presented
public enum PresentationStyle {
    /// The regular sheet presentation style: non-expandable non-scrollable.
    case regular
    /// The sheet could expand to 90% of screen height after being initially presented.
    case expandable
    /// The sheet is now scrollable after it's expanded,
    case scrollable
}
