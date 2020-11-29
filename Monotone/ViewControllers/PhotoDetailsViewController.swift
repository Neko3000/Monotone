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

class PhotoDetailsViewController: BaseViewController {
    
    // MARK: Priavte
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: Controls
    private var photoDetailsOpeartionView: PhotoDetailsOpeartionView!
    private var photoZoomableScrollView: PhotoZoomableScrollView!
    
    private var likeBtn: CapsuleButton!
    private var collectBtn: CapsuleButton!
    private var expandBtn: UIButton!
    
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
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(30.0)
        }
        
        // likeBtn.
        self.likeBtn = CapsuleButton()
        self.likeBtn.setTitle("20", for: .normal)
        self.likeBtn.setImage(UIImage(named: "details-btn-like"), for: .normal)
        self.likeBtn.backgroundStyle = .blur
        self.view.addSubview(self.likeBtn)
        self.likeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(17.0)
            make.bottom.equalTo(self.photoDetailsOpeartionView.snp.top).offset(-40)
        }
        
        // collectBtn.
        self.collectBtn = CapsuleButton()
        self.collectBtn.setTitle("Collect", for: .normal)
        self.collectBtn.setImage(UIImage(named: "details-btn-collect"), for: .normal)
        self.collectBtn.backgroundStyle = .blur
        self.view.addSubview(self.collectBtn)
        self.collectBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.likeBtn.snp.right).offset(10.0)
            make.centerY.equalTo(self.likeBtn)
        }
        
        // expandBtn.
        self.expandBtn = UIButton()
        self.expandBtn.setImage(UIImage(named: "details-btn-expand"), for: .normal)
        self.view.addSubview(self.expandBtn)
        self.expandBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-17.0)
            make.centerY.equalTo(self.likeBtn)
        }
        
    }
    
    override func buildLogic() {
                
        // ViewModel.
        let photoDetailsViewModel = self.viewModel(type:PhotoDetailsViewModel.self)
        
        // photoZoomableScrollView
        photoDetailsViewModel?.output.photo.subscribe(onNext: { (photo) in
            self.photoZoomableScrollView.photo = photo
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
