//
//  RightPresentationController.swift
//  CustomViewTransition
//
//  Created by Yoshikuni Kato on 2016/03/22.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit

class RightPresentationController: UIPresentationController {
    
    private let dimingView = UIView()
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        dimingView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        guard let containerView = containerView else {
            return
        }
        
        dimingView.frame = containerView.bounds
        dimingView.alpha = 0.0
        containerView.insertSubview(dimingView, atIndex: 0)
        
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ (context) in
            self.dimingView.alpha = 1.0
            }, completion: nil
        )
    }
    
    override func presentationTransitionDidEnd(completed: Bool) {
        super.presentationTransitionDidEnd(completed)

        guard !completed else {
            return
        }
        
        dimingView.removeFromSuperview()
    }
    
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ (context) in
            self.dimingView.alpha = 0.0
            }, completion: nil)
    }
    override func dismissalTransitionDidEnd(completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        guard completed else {
            return
        }
        dimingView.removeFromSuperview()
    }
   
    override func frameOfPresentedViewInContainerView() -> CGRect {
        guard let containerView = containerView else {
            return CGRectZero
        }
        return CGRectMake(containerView.bounds.width / 4.0, 0.0, containerView.bounds.width * 3.0 / 4.0, containerView.bounds.height)
    }
}