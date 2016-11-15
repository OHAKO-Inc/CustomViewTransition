//
//  RightViewControllerAnimatedTransitioning.swift
//  CustomViewTransition
//
//  Created by Yoshikuni Kato on 2016/03/22.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit

class RightViewControllerAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    fileprivate let transitionType: AnimatedTransitioningType
    
    init(transitionType: AnimatedTransitioningType) {
        self.transitionType = transitionType
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        switch transitionType {
        case .presentation:
            presentationTransition(containerView, transitionContext: transitionContext)
            
        case .dismissal:
            dismissalTransition(containerView, transitionContext: transitionContext)

        }
        
    }
    
    fileprivate func presentationTransition(_ containerView: UIView, transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
                return
        }
        
        let initialFrame = CGRect(x: containerView.bounds.width, y: 0.0, width: toView.bounds.width, height: toView.bounds.height)
        let finalFrame = transitionContext.finalFrame(for: toVC)

        toView.frame = initialFrame
        containerView.addSubview(toView)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                toView.frame = finalFrame

                transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)?.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                
        }, completion: { (finished: Bool) in
            if transitionContext.transitionWasCancelled {
                toView.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }) 
    }
 
    fileprivate func dismissalTransition(_ containerView: UIView, transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
            return
        }
        
        let finalFrame = CGRect(x: containerView.bounds.width, y: 0.0, width: fromView.bounds.width, height: fromView.bounds.height)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fromView.frame = finalFrame
                transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)?.view.transform = CGAffineTransform.identity
        }, completion: { (finished: Bool) in
            if !transitionContext.transitionWasCancelled {
                fromView.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }) 
    }
    
}

