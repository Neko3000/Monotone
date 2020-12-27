//
//  FloatBlockButton.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/4.
//

import UIKit

class FloatBlockButton: BaseButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    // MARK: - Life Cycle
    override func buildSubviews() {
        super.buildSubviews()
        
        self.backgroundColor = ColorPalette.colorWhite
        
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        self.setTitleColor(ColorPalette.colorBlack, for: .normal)
        
        self.layer.cornerRadius = 6.0
        // self.layer.masksToBounds = true
        
    }
     
    override func buildLogic() {
        super.buildLogic()
        
    }
    
    // https://stackoverflow.com/questions/4201959/label-under-image-in-uibutton
    // by RaffAl, answered Mar 24 '14 at 22:07.
    private func centerVertically(padding: CGFloat = 0) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
            return
        }

        let totalHeight = imageViewSize.height + titleLabelSize.height + padding

        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )

        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )

        self.contentEdgeInsets = UIEdgeInsets(
            top: 10.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.centerVertically()
        self.applyShadow()
    }
    
    private func applyShadow() {
        // Shadow.
        self.layer.applySketchShadow(color: ColorPalette.colorShadow, alpha: 1.0, x: 0, y: 2.0, blur: 10.0, spread: 0)
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 6.0).cgPath
    }
}
