//
//  ZoomableScrollView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/27.
//

import UIKit

class ZoomableScrollView: UIScrollView, UIScrollViewDelegate {
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(photo: Photo){
        self.init()
        
    }
    
    public var imageView: UIImageView? {
        didSet{
            self.updateContentSize(width: imageView?.image?.size.width ?? 0, height: imageView?.image?.size.height ?? 0)
        }
    }
    
    private func updateImageFrame(){
        
        let boundsWidth = self.bounds.size.width
        let boundsHeight = self.bounds.size.height
        
        let contentWidth = self.contentSize.width
        let contentHeight = self.contentSize.height
        
        let centerX = contentWidth > boundsWidth ? contentWidth / 2.0 : boundsWidth / 2.0;
        let centerY = contentHeight > boundsHeight ? contentHeight / 2.0 : boundsHeight / 2.0;
        
        self.imageView?.center = CGPoint(x: centerX, y: centerY)
    }
    
    private func updateContentSize(width: CGFloat, height: CGFloat){
        self.contentSize = CGSize(width: width, height: height)
        self.updateImageFrame()
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.updateImageFrame()
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    

}
