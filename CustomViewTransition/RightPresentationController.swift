//
//  RightPresentationController.swift
//  CustomViewTransition
//
//  Created by Yoshikuni Kato on 2016/03/22.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit

class RightPresentationController: UIPresentationController {
    
    fileprivate let dimmingView = UIView()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        dimmingView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        dimmingView.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(dimmingViewDidTap(_:)))]
    }
    
    @objc func dimmingViewDidTap(_ sender: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: UIPresentationController
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        guard let containerView = containerView else {
            return
        }
        
        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0.0
        containerView.insertSubview(dimmingView, at: 0)
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (context) in
            self.dimmingView.alpha = 1.0
            }, completion: nil
        )
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)

        guard !completed else {
            return
        }
        
        dimmingView.removeFromSuperview()
    }
    
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (context) in
            self.dimmingView.alpha = 0.0
            }, completion: nil)
    }
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        guard completed else {
            return
        }
        dimmingView.removeFromSuperview()
    }
   
    override var frameOfPresentedViewInContainerView : CGRect {
        guard let containerView = containerView else {
            return CGRect.zero
        }
        return CGRect(x: containerView.bounds.width / 4.0, y: 0.0, width: containerView.bounds.width * 3.0 / 4.0, height: containerView.bounds.height)
    }
}
