//
//  SpaceLabel.swift
//  Monotone
//
//  Created by Xueliang Chen on 1/10/21.
//

import UIKit

// https://stackoverflow.com/questions/27459746/adding-space-padding-to-a-uilabel
// Tai Le, answered Sep 3 '15 at 7:00
class SpaceLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    // MARK: - Public
    public var paddingInsets: UIEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0){
        didSet{
            self.layoutIfNeeded()
        }
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: paddingInsets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + paddingInsets.left + paddingInsets.right,
                      height: size.height + paddingInsets.top + paddingInsets.bottom)
    }

    override var bounds: CGRect {
        didSet {
            // Ensures this works within stack views if multi-line.
            preferredMaxLayoutWidth = bounds.width - (paddingInsets.left + paddingInsets.right)
        }
    }
}
