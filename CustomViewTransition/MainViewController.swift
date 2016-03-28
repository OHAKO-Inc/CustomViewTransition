//
//  MainViewController.swift
//  CustomViewTransition
//
//  Created by Yoshikuni Kato on 2016/03/22.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBAction func rightDidTap(sender: AnyObject) {
        label.text = "right"
        let rightViewController = RightViewController.instantiate()
        rightViewController.modalPresentationStyle = .Custom
        rightViewController.transitioningDelegate = self
        presentViewController(rightViewController, animated: true, completion: nil)
    }
    @IBAction func leftDidTap(sender: AnyObject) {
        label.text = "left"
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return RightPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return RightViewControllerAnimatedTransitioning(transitionType: .Presentation)
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return RightViewControllerAnimatedTransitioning(transitionType: .Dismissal)
    }
}
