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
    
    // MARK: - Public
    public var photo: Photo?{
        didSet{
            self.updatePhoto()
        }
    }
    
    // MARK: - Private
    private var photoUpdated: Bool = false
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Controls
    public var photoImageView: UIImageView!
    
    // MARK: - Life Cycle
    override func buildSubviews(){
        super.buildSubviews()
        
        // delegate.
        self.delegate = self

        // photoImageView.
        self.photoImageView = UIImageView()
        self.photoImageView.contentMode = .scaleToFill
        self.addSubview(self.photoImageView)
    }
    
    override func buildLogic(){
        super.buildLogic()
        
        self.rx.observe(CGRect.self, #keyPath(UIView.bounds))
            .filter({ (rect) -> Bool in
                return rect != CGRect.zero
            })
            .distinctUntilChanged({ (oldValue, newValue) -> Bool in
                return oldValue?.size == newValue?.size
            })
            .subscribe(onNext: { _ in

                self.updatePhotoSize()
                self.updatePhotoPosition()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func updatePhoto(){
        self.photoImageView.kf.setImage(with: URL(string: photo!.urls?.regular ?? ""),
                                        placeholder: UIImage(blurHash: photo!.blurHash ?? "", size: CGSize(width: 10, height: 10)),
                                        options: [.transition(.fade(1.0)), .originalCache(.default)])
        
        self.updatePhotoSize()
        self.updatePhotoPosition()
        self.photoUpdated = true
    }
    
    private func updatePhotoSize(){
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
    }
    
    private func updatePhotoPosition(){
        let boundsWidth = self.bounds.size.width
        let boundsHeight = self.bounds.size.height
        
        let contentWidth = self.contentSize.width
        let contentHeight = self.contentSize.height
        
        // FIX: Bounds is not always equal to zero.
        let centerX = contentWidth > boundsWidth ? contentWidth / 2.0 : boundsWidth / 2.0 + self.bounds.origin.x;
        let centerY = contentHeight > boundsHeight ? contentHeight / 2.0 : boundsHeight / 2.0 + self.bounds.origin.y;
        
        self.photoImageView.center = CGPoint(x: centerX, y: centerY)
    }
    
    public func adjustZoomScale(scaleToFill: Bool, animated: Bool){
        let boundsWidth = self.bounds.size.width
        let boundsHeight = self.bounds.size.height
        let boundsRatio =  boundsHeight / boundsWidth

        let photoHeight = CGFloat(self.photo!.height!)
        let photoWidth = CGFloat(self.photo!.width!)
        let photoRatio = photoHeight / photoWidth
        
        if(scaleToFill){
            if(photoRatio >= boundsRatio){
                self.setZoomScale(boundsWidth * photoRatio / boundsHeight, animated: animated)
            }
            else{
                self.setZoomScale(boundsHeight / (boundsWidth * photoRatio), animated: animated)
            }
        }
        else{
            self.setZoomScale(1.0, animated: animated)
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
