//
//  BounceController.swift
//  CustomizeTransition
//
//  Created by Michael on 18/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit

class BounceController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 5.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: .to )
        let finalFrame = transitionContext.finalFrame(for: toVC!)
        let containerView = transitionContext.containerView
        
        let screenBounds = UIScreen.main.bounds
        
        toVC!.view.frame = finalFrame.offsetBy(dx: 0, dy: screenBounds.size.height)
        containerView.addSubview((toVC?.view)!)
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveLinear, animations: {
            toVC?.view.frame = finalFrame

        }, completion: { (finished) in
            transitionContext.completeTransition(true)
            
        })
        
//        UIView.animate(withDuration: 2.0) {
//        }
        
        
        
    }
    

}
