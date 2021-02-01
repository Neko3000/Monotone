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
    
    // Float.
    public static func float(views:[UIView]){
        
        let animation = AnimationType.vector(CGVector(dx: 0, dy: 50))
        
        UIView.animate(views:views,
                       animations: [animation],
                       animationInterval: animationInterval,
                       duration: duration)
    }
}
