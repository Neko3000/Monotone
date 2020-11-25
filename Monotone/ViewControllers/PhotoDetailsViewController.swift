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
        
        return
        
        // scrollView.
        self.scrollView = UIScrollView()
        self.scrollView.maximumZoomScale = 5.0
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.delegate = self
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints({ (make) in
            make.top.right.bottom.left.equalTo(self.view)
        })
        
        // photoImageView.
        self.photoImageView = UIImageView()
        self.photoImageView.kf.setImage(with: URL(string: "https://images.unsplash.com/photo-1606064979325-2ef27740a089?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjE3ODkzOX0"))
        self.scrollView.addSubview(self.photoImageView)
        
        // photoDetailsOpeartionView.
        self.photoDetailsOpeartionView = PhotoDetailsOpeartionView()
        self.view.addSubview(self.photoDetailsOpeartionView)
        self.photoDetailsOpeartionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
    }
    
    override func buildLogic() {
        
        return
        
        // ViewModel.
        let photoDetailsViewModel = self.viewModel(type:PhotoDetailsViewModel.self)
        
        // photo.
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        let screenRatio =  screenHeight / screenWidth

        let photoHeight = CGFloat(photoDetailsViewModel!.output.photo.value.height!)
        let photoWidth = CGFloat(photoDetailsViewModel!.output.photo.value.width!)
        let photoRatio = photoHeight / photoWidth
        
        if(photoRatio >= screenRatio){
            self.photoImageView.frame.size = CGSize(width: photoRatio * photoWidth, height: screenHeight)
        }
        else{
            self.photoImageView.frame.size = CGSize(width: photoWidth, height: photoHeight / photoRatio)
        }
        
        self.photoImageView.center = self.scrollView.convert(self.scrollView.center, to: self.view)
        
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.photoImageView
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
