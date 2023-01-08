//
//  QuickSheet+UIViewControllerTransitioningDelegate.swift
//  QuickSheets
//
//  Created by Ahmed Fathy on 05/01/2023.
//

import UIKit

class TransitionController: NSObject, UIViewControllerTransitioningDelegate {
    let dismissController = DismissController()
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissController
    }
}

class DismissController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let viewC = transitionContext.viewController(forKey: .from) as? QuickSheetWrapper else { return }
        viewC.animateDown {
            transitionContext.completeTransition(true)
        }
    }
}
