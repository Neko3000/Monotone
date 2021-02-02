//
//  BaseView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/3.
//

import UIKit

// MARK: - ViewAnimatable
protocol ViewAnimatable {
    associatedtype AnimationStateType
    
    func animation(animationState: AnimationStateType)
}
let viewBuildAnimation = "buildAnimation"

// MARK: - ViewWithAnimator
protocol ViewWithAnimator {
    
    func buildAnimator()
}
let viewBuildAnimator = "buildAnimator"

// MARK: - BaseView
class BaseView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.buildSubviews()
        self.buildLogic()
        
        // Call buildAnimation method of the subclass.
        if(self.responds(to: Selector(viewBuildAnimation))){
            self.perform(Selector(viewBuildAnimation))
        }

        // Call buildAnimator method of the subclass.
        if(self.responds(to: Selector(viewBuildAnimator))){
            self.perform(Selector(viewBuildAnimator))
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func buildSubviews(){
        // Implemented by subclass.
    }
    
    func buildLogic(){
        // Implemented by subclass.
    }
}
