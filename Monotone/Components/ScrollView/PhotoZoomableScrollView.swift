//
//  ZoomableScrollView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/27.
//

import UIKit

import RxRelay
import Kingfisher

class PhotoZoomableScrollView: BaseScrollView, UIScrollViewDelegate {
    
    // MARK: Public
    public var photo: Photo?{
        didSet{
            self.updatePhoto(photo: photo!)
        }
    }
    
    // MARK: Private
    private var photoUpdated: Bool = false
    
    // MARK: Controls
    private var photoImageView: UIImageView!
    
    // MARK: Life Cycle
    override func buildSubviews(){
        self.delegate = self

        // photoImageView.
        self.photoImageView = UIImageView()
        self.photoImageView.contentMode = .scaleToFill
        self.addSubview(self.photoImageView)
    }
    
    override func buildLogic(){
        
        //
    }
    
    func updatePhoto(photo: Photo){
        self.photoImageView.kf.setImage(with: URL(string: self.photo!.urls?.full ?? ""),
                                        placeholder: UIImage(blurHash: self.photo!.blurHash ?? "", size: CGSize(width: 10, height: 10)),
                                        options: [.transition(.fade(1.0)), .originalCache(.default)])
        
        self.updatePhotoSize()
        self.photoUpdated = true
    }
    
    func updatePhotoSize(){
        let boundsWidth = self.bounds.size.width
        let boundsHeight = self.bounds.size.height
        let boundsRatio =  boundsHeight / boundsWidth

        let photoHeight = CGFloat(self.photo!.height!)
        let photoWidth = CGFloat(self.photo!.width!)
        let photoRatio = photoHeight / photoWidth
        
        if(photoRatio >= boundsRatio){
            self.photoImageView.frame.size = CGSize(width: (boundsHeight / photoHeight) * photoWidth, height: boundsHeight)
        }
        else{
            self.photoImageView.frame.size = CGSize(width: boundsWidth, height: (boundsWidth / photoWidth) * photoHeight)
        }
        
        let contentWidth = self.contentSize.width
        let contentHeight = self.contentSize.height
        
        let centerX = contentWidth > boundsWidth ? contentWidth / 2.0 : boundsWidth / 2.0;
        let centerY = contentHeight > boundsHeight ? contentHeight / 2.0 : boundsHeight / 2.0;
        
        self.photoImageView.center = CGPoint(x: centerX, y: centerY)
    }
    
    func updatePhotoPosition(){
        let boundsWidth = self.bounds.size.width
        let boundsHeight = self.bounds.size.height
        
        let contentWidth = self.contentSize.width
        let contentHeight = self.contentSize.height
        
        let centerX = contentWidth > boundsWidth ? contentWidth / 2.0 : boundsWidth / 2.0;
        let centerY = contentHeight > boundsHeight ? contentHeight / 2.0 : boundsHeight / 2.0;
        
        self.photoImageView.center = CGPoint(x: centerX, y: centerY)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(photoUpdated){
            self.updatePhotoSize()
            self.photoUpdated = false
        }
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.updatePhotoPosition()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.photoImageView
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    

}
