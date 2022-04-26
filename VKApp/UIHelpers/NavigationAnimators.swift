//
//  NavigationAnimators.swift
//  VKApp
//
//  Created by Никита Мошенцев on 30.01.2022.
//

import UIKit

final class PushAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let animateTime = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        source.view.setAnchorPoint(CGPoint(x: 1.0, y: 0.0))
        destination.view.setAnchorPoint(CGPoint(x: 1.0, y: 0.0))
        
        transitionContext.containerView.addSubview(destination.view)
        
        destination.view.frame = transitionContext.containerView.frame
        destination.view.transform = CGAffineTransform(
            rotationAngle:  -.pi / 2)
        
        
        
        UIView.animateKeyframes(
            withDuration: animateTime,
            delay: 0.0,
            options: .calculationModePaced) {
     
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.75) {
                    let rotation = CGAffineTransform(
                        rotationAngle: .pi / 2)
                    source.view.transform = rotation
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.75) {
                    destination.view.transform = .identity
                }
                
            } completion: { isComplete in
                if isComplete && !transitionContext.transitionWasCancelled {
                    source.view.transform = .identity
                }
                
                transitionContext.completeTransition(isComplete && !transitionContext.transitionWasCancelled)
            }
    }
    
}

final class PopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let animateTime = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        source.view.setAnchorPoint(CGPoint(x: 0.0, y: 0.0))
        destination.view.setAnchorPoint(CGPoint(x: 0.0, y: 0.0))
        
        transitionContext.containerView.insertSubview(
            destination.view,
            belowSubview: source.view)
        
        destination.view.frame = transitionContext.containerView.frame
        destination.view.transform = CGAffineTransform(
            rotationAngle: .pi / 2)
        
        UIView.animateKeyframes(
            withDuration: animateTime,
            delay: 0.0,
            options: .calculationModePaced) {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.75) {
                    let rotation = CGAffineTransform(
                        rotationAngle: -.pi / 2)
                    source.view.transform = rotation
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.75) {
                    destination.view.transform = .identity
                }
                
            } completion: { isComplete in
                if isComplete && !transitionContext.transitionWasCancelled {
                    source.removeFromParent()
                } else if transitionContext.transitionWasCancelled {
                    destination.view.transform = .identity
                }
                
                transitionContext.completeTransition(isComplete && !transitionContext.transitionWasCancelled)
            }
    }
}
