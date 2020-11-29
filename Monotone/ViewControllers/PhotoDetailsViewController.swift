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
import Hero

class PhotoDetailsViewController: BaseViewController {
    
    // MARK: Priavte
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: Controls
    private var photoDetailsOpeartionView: PhotoDetailsOpeartionView!
    private var photoZoomableScrollView: PhotoZoomableScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

    }
    
    override func buildSubviews() {
        self.view.backgroundColor = UIColor.black
                
        // photoZoomableScrollView.
        self.photoZoomableScrollView = PhotoZoomableScrollView()
        self.photoZoomableScrollView.maximumZoomScale = 10.0
        self.photoZoomableScrollView.minimumZoomScale = 1.0
        self.view.addSubview(self.photoZoomableScrollView)
        self.photoZoomableScrollView.snp.makeConstraints({ (make) in
            make.top.right.bottom.left.equalTo(self.view)
        })
        
        // photoDetailsOpeartionView.
        self.photoDetailsOpeartionView = PhotoDetailsOpeartionView()
        self.view.addSubview(self.photoDetailsOpeartionView)
        self.photoDetailsOpeartionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
        self.hero.isEnabled = true
        self.navigationController?.hero.isEnabled = true
        self.photoZoomableScrollView.photoImageView.hero.isEnabledForSubviews = true
        self.photoZoomableScrollView.photoImageView.hero.id =  "selectedPhoto"
    }
    
    override func buildLogic() {
                
        // ViewModel.
        let photoDetailsViewModel = self.viewModel(type:PhotoDetailsViewModel.self)
        
        // photoZoomableScrollView
        photoDetailsViewModel?.output.photo.subscribe(onNext: { (photo) in
            self.photoZoomableScrollView.photo.accept(photo)
        })
        .disposed(by: self.disposeBag)
        
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
