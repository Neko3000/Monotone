//
//  PhotoDetailsViewController.swift
//  
//
//  Created by Xueliang Chen on 2020/11/12.
//

import UIKit

import SnapKit
import RxSwift
import Kingfisher
import anim

class PhotoDetailsViewController: BaseViewController, UIScrollViewDelegate {
    
    // MARK: Priavte
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: Controls
    private var photoDetailsOpeartionView: PhotoDetailsOpeartionView!
    
    private var photoImageView: UIImageView!
    private var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

    }
    
    override func buildSubviews() {
        
        self.view.backgroundColor = UIColor.orange
                
        // scrollView.
        self.scrollView = UIScrollView()
        self.scrollView.maximumZoomScale = 10.0
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.delegate = self
//        self.scrollView.contentSize = CGSize(width: 500, height: 500)
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints({ (make) in
            make.top.right.bottom.left.equalTo(self.view)
        })
        
        // photoImageView.
        self.photoImageView = UIImageView()
//        self.photoImageView.kf.setImage(with: URL(string: "https://images.unsplash.com/photo-1606064979325-2ef27740a089?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjE3ODkzOX0"))
        self.photoImageView.contentMode = .scaleToFill
        self.scrollView.addSubview(self.photoImageView)
//        self.photoImageView.snp.makeConstraints { (make) in
////            make.center.equalTo(self.scrollView)
//        }
        
        // photoDetailsOpeartionView.
        self.photoDetailsOpeartionView = PhotoDetailsOpeartionView()
        self.view.addSubview(self.photoDetailsOpeartionView)
        self.photoDetailsOpeartionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
    }
    
    func updateImageViewSize(){
        // photo.
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        let screenRatio =  screenHeight / screenWidth

        let photoHeight = CGFloat(self.photoImageView.image!.size.height)
        let photoWidth = CGFloat(self.photoImageView.image!.size.width)
        let photoRatio = photoHeight / photoWidth

        if(photoRatio >= screenRatio){
            self.photoImageView.frame.size = CGSize(width: (screenHeight / photoHeight) * photoWidth, height: screenHeight)
//            self.photoImageView.frame = CGRect(x: 0, y: 0, width: (screenHeight / photoHeight) * photoWidth, height: screenHeight)

        }
        else{
            self.photoImageView.frame.size = CGSize(width: screenWidth, height: (screenWidth / photoWidth) * photoHeight)
//            self.photoImageView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: (screenWidth / photoWidth) * photoHeight)
        }
        
//        self.photoImageView.center = self.view.center
    }
    
    override func buildLogic() {
                
        // ViewModel.
        let photoDetailsViewModel = self.viewModel(type:PhotoDetailsViewModel.self)
        
//        // photo.
//        let screenHeight = UIScreen.main.bounds.height
//        let screenWidth = UIScreen.main.bounds.width
//        let screenRatio =  screenHeight / screenWidth
//
//        let photoHeight = CGFloat(photoDetailsViewModel!.output.photo.value.height!)
//        let photoWidth = CGFloat(photoDetailsViewModel!.output.photo.value.width!)
//        let photoRatio = photoHeight / photoWidth
//
//        if(photoRatio >= screenRatio){
////            self.photoImageView.frame.size = CGSize(width: (screenHeight / photoHeight) * photoWidth, height: screenHeight)
//            self.photoImageView.frame = CGRect(x: 0, y: 0, width: (screenHeight / photoHeight) * photoWidth, height: screenHeight)
//
//        }
//        else{
////            self.photoImageView.frame.size = CGSize(width: screenWidth, height: (screenWidth / photoWidth) * photoHeight)
//            self.photoImageView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: (screenWidth / photoWidth) * photoHeight)
//        }
        
        
//        self.photoImageView.center = self.scrollView.convert(self.scrollView.center, to: self.view)
        
        self.photoImageView.frame = CGRect(x: 0, y: 0, width: 800, height: 800)
        
        photoDetailsViewModel?.output.photo.subscribe(onNext: { (photo) in
            self.photoImageView.kf.setImage(with: URL(string: photo.urls?.full ?? ""),
                                            placeholder: UIImage(blurHash: photo.blurHash ?? "", size: CGSize(width: 10, height: 10)),
                                            options: [.transition(.fade(1.0)), .originalCache(.default)],
                                            completionHandler:  { (result) in
                                                switch(result){
                                                case .success(let value):
                                                    self.updateImageViewSize()
                                                    break
                                                case .failure(let error):
                                                    print("Job failed: \(error.localizedDescription)")
                                                    break
                                                }
                                            })
            
        })
        .disposed(by: self.disposeBag)
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.photoImageView
    }
//
//    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
//        if(self.scrollView.zoomScale > 1.0){
//            self.photoImageView.center = CGPoint(x: self.scrollView.contentSize.width / 2.0, y: self.scrollView.contentSize.height / 2.0)
//        }
//        else{
//            self.photoImageView.center = self.view.center
//        }
//    }
//
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let subView = self.photoImageView // get the image view

        let offsetX = max((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0)

        let offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0)

        // adjust the center of image view

        subView?.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX, y: scrollView.contentSize.height * 0.5 + offsetY)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
