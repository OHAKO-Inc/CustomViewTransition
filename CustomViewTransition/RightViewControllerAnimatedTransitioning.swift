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
        return 3.0
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let containerView = transitionContext.containerView() else {
            return
        }

        switch transitionType {
        case .Presentation:
            
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
            }) { (finished: Bool) in
                transitionContext.completeTransition(finished)
            }

            
        case .Dismissal:
            
            guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
                let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey) else {
                    return
            }
            
            let finalFrame = CGRectMake(containerView.bounds.width, 0.0, containerView.bounds.width, containerView.bounds.height)
            
            UIView.animateWithDuration(
                transitionDuration(transitionContext),
                animations: {
                    fromView.frame = finalFrame
            }) { (finished: Bool) in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(finished)
            }
            

        }
        
        
    }
    
}

