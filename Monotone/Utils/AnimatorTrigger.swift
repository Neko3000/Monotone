//
//  AnimatorTrigger.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/2/1.
//

import Foundation
import UIKit

import ViewAnimator

class AnimatorTrigger{
    
    // AnimationInterval.
    public static var animationInterval: TimeInterval = 0.2
    
    // Duration.
    public static var duration: TimeInterval = 0.3
    
    // MARK: - Float Animation.
    enum FloatDirection{
        case toTop
        case toRight
        case toBottom
        case toLeft
    }
    
    public static func float(views:[UIView],
                             direction: FloatDirection = .toTop,
                             delay: Double = 0.1,
                             animationInterval:TimeInterval = animationInterval,
                             duration:TimeInterval = duration){
        
        let volumn: CGFloat = 50.0
        
        var vector : CGVector?
        switch direction {
        case .toTop:
            vector = CGVector(dx: 0, dy: volumn)
            break
        case .toRight:
            vector = CGVector(dx: -volumn, dy: 0)
            break
        case .toBottom:
            vector = CGVector(dx: 0, dy: -volumn)
            break
        case .toLeft:
            vector = CGVector(dx: volumn, dy: 0)
            break
        }
        
        let animation = AnimationType.vector(vector!)
        
        UIView.animate(views:views,
                       animations: [animation],
                       delay: delay,
                       animationInterval: animationInterval,
                       duration: duration)
    }
}
