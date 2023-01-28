//
//  ViewController.swift
//  QuickSheet_Example
//
//  Created by Ahmed Fathy on 09/01/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import QuickSheet
import SwiftUI

class ViewController: UIViewController {
    lazy var preferencesView = PreferencesView { options, viewController  in
        self.presentQuickSheet(viewController, options: options)
    }
    lazy var hosting = UIHostingController(rootView: preferencesView)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChild(hosting)
        self.view.addSubview(hosting.view)
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.view.leadingAnchor.constraint(equalTo: hosting.view.leadingAnchor),
            self.view.topAnchor.constraint(equalTo: hosting.view.topAnchor),
            self.view.trailingAnchor.constraint(equalTo: hosting.view.trailingAnchor),
            self.view.bottomAnchor.constraint(equalTo: hosting.view.bottomAnchor)
        ])
    }
    
}
