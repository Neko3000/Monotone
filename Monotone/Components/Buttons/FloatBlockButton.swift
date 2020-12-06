//
//  FloatBlockButton.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/4.
//

import UIKit

import RxSwift
import RxRelay

class FloatBlockButton: BaseButton {
    
    // MARK: Private
    let disposeBag: DisposeBag = DisposeBag()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func buildSubviews() {
        super.buildSubviews()
        
        self.backgroundColor = ColorPalette.colorWhite
        
        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = true
        
        // Layout.
        self.centerVertically()
        
        // Shadow.
        self.layer.applySketchShadow(color: ColorPalette.colorShadow, alpha: 1.0, x: 0, y: 2.0, blur: 10.0, spread: 0)
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        self.rx.observe(CGRect.self, #keyPath(UIView.bounds))
            .filter({ (rect) -> Bool in
                return rect != CGRect.zero
            })
            .distinctUntilChanged({ (rectA, rectB) -> Bool in
                return rectA?.size == rectB?.size
            })
            .subscribe(onNext: { _ in

                self.centerVertically()
            })
            .disposed(by: self.disposeBag)
    }
    
    // https://stackoverflow.com/questions/4201959/label-under-image-in-uibutton
    // by RaffAl at Jun/20.
    private func centerVertically(padding: CGFloat = 6.0) {
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
                top: 0.0,
                left: 0.0,
                bottom: titleLabelSize.height,
                right: 0.0
            )
        }

}
