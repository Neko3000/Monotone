//
//  MTTextField.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/16.
//

import UIKit

class MTTextField: UITextField {
    
    // MARK: - Public
    public var iconLeftMargin: CGFloat = 10.0{
        didSet{
            self.layoutIfNeeded()
        }
    }
    public var textLeftMargin: CGFloat = 15.0{
        didSet{
            self.layoutIfNeeded()
        }
    }
    
    // MARK: - Life Cycle
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += iconLeftMargin
        return rect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        rect.origin.x += textLeftMargin
        return rect
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds)
        rect.origin.x += textLeftMargin
        return rect
    }


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
