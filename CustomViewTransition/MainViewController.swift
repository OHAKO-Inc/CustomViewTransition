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
    @IBAction func rightDidTap(_ sender: AnyObject) {
        label.text = "right"
        let rightViewController = RightViewController.instantiate()
        rightViewController.modalPresentationStyle = .custom
        rightViewController.transitioningDelegate = self
        present(rightViewController, animated: true, completion: nil)
    }
    @IBAction func leftDidTap(_ sender: AnyObject) {
        label.text = "left"
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return RightPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return RightViewControllerAnimatedTransitioning(transitionType: .presentation)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return RightViewControllerAnimatedTransitioning(transitionType: .dismissal)
    }
}
