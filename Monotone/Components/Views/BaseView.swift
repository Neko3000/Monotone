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
