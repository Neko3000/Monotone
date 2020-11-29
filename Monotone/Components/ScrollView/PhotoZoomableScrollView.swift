//
//  ZoomableScrollView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/27.
//

import UIKit

import RxSwift
import RxRelay
import Kingfisher

class PhotoZoomableScrollView: BaseScrollView, UIScrollViewDelegate {
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: Public
    public var photo: BehaviorRelay<Photo?> = BehaviorRelay<Photo?>(value: nil)
    
    // MARK: Private
    private var photoUpdated: Bool = false
    
    // MARK: Controls
    public var photoImageView: UIImageView!
    
    // MARK: Life Cycle
    override func buildSubviews(){
        self.delegate = self

        // photoImageView.
        self.photoImageView = UIImageView()
        self.photoImageView.contentMode = .scaleToFill
        self.addSubview(self.photoImageView)
    }
    
    override func buildLogic(){
        
        // photo.
        self.photo
            .filter({ $0 != nil})
            .subscribe(onNext: { photo in
                self.photoImageView.kf.setImage(with: URL(string: photo!.urls?.regular ?? ""),
                                                placeholder: UIImage(blurHash: photo!.blurHash ?? "", size: CGSize(width: 10, height: 10)),
                                                options: [.transition(.fade(1.0)), .originalCache(.default)])
                
                self.updatePhotoSize()
                self.photoUpdated = true
            })
            .disposed(by: self.disposeBag)
        
        // didZoom.
        self.rx.didZoom
            .subscribe(onNext: { _ in
                self.updatePhotoPosition()
            })
            .disposed(by: self.disposeBag)
        
        // layoutSubviews.
        self.rx.sentMessage(#selector(layoutSubviews))
            .filter({ _ in self.photo.value != nil && self.photoUpdated == true })
            .subscribe { (_) in
                
            self.updatePhotoSize()
            self.photoUpdated = false
        }
        .disposed(by: self.disposeBag)
    }
    
    func updatePhotoSize(){
        let boundsWidth = self.bounds.size.width
        let boundsHeight = self.bounds.size.height
        let boundsRatio =  boundsHeight / boundsWidth

        let photoHeight = CGFloat(self.photo.value!.height!)
        let photoWidth = CGFloat(self.photo.value!.width!)
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
