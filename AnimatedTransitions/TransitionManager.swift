//
//  TransitionManager.swift
//  AnimatedTransitions
//
//  Created by Mitchell Porter on 8/19/15.
//  Copyright (c) 2015 Mentor Ventures. All rights reserved.
//

import UIKit

import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate  {
    
    var presenting: Bool?
    
    // MARK: UIViewControllerAnimatedTransitioning protocol methods
    
    // animate a change from one viewcontroller to another
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // TODO: Perform the animation
        
        // get reference to our fromView, toView and the container view that we should perform the transition in
        let container = transitionContext.containerView()
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        // set up from 2D transforms that we'll use in the animation
        let offScreenRight = CGAffineTransformMakeTranslation(container.frame.width, 0)
        let offScreenLeft = CGAffineTransformMakeTranslation(-container.frame.width, 0)
        
        // set up from 2D transforms that we'll use in the animation
        let π : CGFloat = 3.14159265359
        
        let offScreenRotateIn = CGAffineTransformMakeRotation(-π/2)
        let offScreenRotateOut = CGAffineTransformMakeRotation(π/2)
        
        // set the start location of toView depending if we're presenting or not
        toView.transform = self.presenting! ? offScreenRotateIn : offScreenRotateOut
        
        // set the anchor point so that rotations happen from the top-left corner
        toView.layer.anchorPoint = CGPoint(x:0, y:0)
        fromView.layer.anchorPoint = CGPoint(x:0, y:0)
        
        // updating the anchor point also moves the position to we have to move the center position to the top-left to compensate
        toView.layer.position = CGPoint(x:0, y:0)
        fromView.layer.position = CGPoint(x:0, y:0)
        
        // add the both views to our view controller
        container.addSubview(toView)
        container.addSubview(fromView)
        
        // get the duration of the animation
        // DON'T just type '0.5s' -- the reason why won't make sense until the next post
        // but for now it's important to just follow this approach
        let duration = self.transitionDuration(transitionContext)
        
        // perform the animation!
        // for this example, just slid both fromView and toView to the left at the same time
        // meaning fromView is pushed off the screen and toView slides into view
        // we also use the block animation usingSpringWithDamping for a little bounce
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: nil, animations: {
            
            if self.presenting == true {
                fromView.transform = offScreenLeft
            } else {
                fromView.transform = offScreenRight
            }
            
            
            toView.transform = CGAffineTransformIdentity
            
            }, completion: { finished in
                
                // tell our transitionContext object that we've finished animating
                transitionContext.completeTransition(true)
                
        })
    }
    
    // return how many seconds the transiton animation will take
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    // MARK: UIViewControllerTransitioningDelegate protocol methods
    
    // return the animataor when presenting a viewcontroller
    // remmeber that an animator (or animation controller) is any object that adheres to the UIViewControllerAnimatedTransitioning protocol
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    // return the animator used when dismissing from a viewcontroller
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
}