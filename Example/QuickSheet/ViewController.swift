//
//  ViewController.swift
//  QuickSheet_Example
//
//  Created by Ahmed Fathy on 09/01/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import QuickSheet

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didPressPresent(_ sender: UIButton) {
        let dummyVC = storyboard!.instantiateViewController(withIdentifier: "DummyVC")
        let shadowStyle = QuickSheetOptions.ShadowStyle(shadowRadius: Preferences.values[.shadowRadius] as! CGFloat,
                                                        shadowColor: .black,
                                                        shadowOpacity: Preferences.values[.shadowOpacity] as! Float)
        let customOptions = QuickSheetOptions(fraction: Preferences.values[.fraction] as! Double,
                                              isExpandable: Preferences.values[.expandable] as! Bool,
                                              isScrollable: Preferences.values[.scrollable] as! Bool,
                                              cornerRadius: Preferences.values[.cornerRadius] as! CGFloat,
                                              blurEffect: Preferences.values[.blurEffect] as! UIBlurEffect.Style,
                                              shadowStyle: shadowStyle)
        self.presentQuickSheet(dummyVC, options: customOptions)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Preferences.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PreferenceCell
        cell.key = Preferences.allCases[indexPath.row]
        return cell
    }
    
    
}
