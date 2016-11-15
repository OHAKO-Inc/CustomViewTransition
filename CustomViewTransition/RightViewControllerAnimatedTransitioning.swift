//
//  RightViewControllerAnimatedTransitioning.swift
//  CustomViewTransition
//
//  Created by Yoshikuni Kato on 2016/03/22.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit

class RightViewControllerAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    private let transitionType: AnimatedTransitioningType
    
    init(transitionType: AnimatedTransitioningType) {
        self.transitionType = transitionType
        super.init()
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        
        switch transitionType {
        case .Presentation:
            presentationTransition(containerView, transitionContext: transitionContext)
            
        case .Dismissal:
            dismissalTransition(containerView, transitionContext: transitionContext)

        }
        
    }
    
    private func presentationTransition(containerView: UIView, transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey) else {
                return
        }
        
        let initialFrame = CGRectMake(containerView.bounds.width, 0.0, toView.bounds.width, toView.bounds.height)
        let finalFrame = transitionContext.finalFrameForViewController(toVC)

        toView.frame = initialFrame
        containerView.addSubview(toView)
        
        UIView.animateWithDuration(
            transitionDuration(transitionContext),
            animations: {
                toView.frame = finalFrame

                transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.transform = CGAffineTransformMakeScale(0.95, 0.95)
                
        }) { (finished: Bool) in
            if transitionContext.transitionWasCancelled() {
                toView.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
 
    private func dismissalTransition(containerView: UIView, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey) else {
            return
        }
        
        let finalFrame = CGRectMake(containerView.bounds.width, 0.0, fromView.bounds.width, fromView.bounds.height)
        
        UIView.animateWithDuration(
            transitionDuration(transitionContext),
            animations: {
                fromView.frame = finalFrame
                transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)?.view.transform = CGAffineTransformIdentity
        }) { (finished: Bool) in
            if !transitionContext.transitionWasCancelled() {
                fromView.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
    
}

