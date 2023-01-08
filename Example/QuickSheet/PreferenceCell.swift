//
//  PreferenceCell.swift
//  QuickSheet_Example
//
//  Created by Ahmed Fathy on 08/01/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

class PreferenceCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var preferenceSwitch: UISwitch!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperValueLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    
    var key: Preferences! {
        didSet {
            initializeCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    fileprivate func initializeCell() {
        self.titleLabel.text = key.description
        switch key {
        case .scrollable, .expandable:
            preferenceSwitch.isHidden = false
        case .shadowRadius, .cornerRadius, .shadowOpacity, .fraction:
            initializeIfStepper()
        case .blurEffect:
            initializeMenu()
            
        default:
            break
        }
    }
    
    fileprivate func initializeMenu() {
        menuButton.isHidden = false
        let actions = UIBlurEffect.Style.allCases.map { style in
            UIAction(title: "\(style)") { _ in
                Preferences.values[.blurEffect] = style
            }
        }
        let menu = UIMenu(title: "Blur Effects", children: actions)
        menuButton.menu = menu
    }
    
    fileprivate func initializeIfStepper() {
        stepper.isHidden = false
        stepperValueLabel.isHidden = false
        switch key {
        case .fraction:
            stepper.minimumValue = 0.3
            stepper.maximumValue = 0.8
            stepper.stepValue = 0.05
        case .cornerRadius:
            stepper.minimumValue = 5.0
            stepper.maximumValue = 30.0
            stepper.stepValue = 5.0
        case .shadowRadius:
            stepper.minimumValue = 10.0
            stepper.maximumValue = 30.0
            stepper.stepValue = 2.5
        case .shadowOpacity:
            stepper.minimumValue = 0.1
            stepper.maximumValue = 0.9
            stepper.stepValue = 0.1
        default:
            break
        }
        stepperValueLabel.text = String(format: "%.2f", stepper.value)
    }

    @IBAction func didSwitchBool(_ sender: UISwitch) {
        switch key {
        case .scrollable:
            Preferences.values[.scrollable] = sender.isOn
        case .expandable:
            Preferences.values[.expandable] = sender.isOn
        default:
            break
        }
    }
    
    @IBAction func didChangeStepperValue(_ sender: UIStepper) {
        stepperValueLabel.text = String(format: "%.2f", sender.value)
        switch key {
        case .fraction:
            Preferences.values[key] = sender.value
        case .shadowRadius, .cornerRadius:
            Preferences.values[key] = CGFloat(sender.value)
        case .shadowOpacity:
            Preferences.values[key] = Float(sender.value)
        default:
            break
        }
    }
    
}
