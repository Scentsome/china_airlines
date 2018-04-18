//
//  ShrinkController.swift
//  CustomizeTransition
//
//  Created by Michael on 18/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class ShrinkController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let finalToVCFrame = transitionContext.finalFrame(for: toVC!)
        let containerView = transitionContext.containerView
        toVC?.view.frame = finalToVCFrame
        toVC?.view.alpha = 0.5
        containerView.addSubview(toVC!.view)
        containerView.sendSubview(toBack: toVC!.view)
        let screenBounds = UIScreen.main.bounds
        let fromVCFrame = (fromVC?.view.frame)!
        let shrunkenFrame = fromVCFrame.insetBy(dx: fromVCFrame.size.width/4, dy: fromVCFrame.size.height/4)
        let finalFromVCFrame = shrunkenFrame.insetBy(dx: 0, dy: screenBounds.size.height)
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                fromVC!.view.frame = shrunkenFrame
                toVC!.view.alpha = 0.5
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                fromVC!.view.frame = finalFromVCFrame;
                toVC!.view.alpha = 1.0;
            })
            
        }) { (finished:Bool) in
            transitionContext.completeTransition(true)
        }
    }
    

}
