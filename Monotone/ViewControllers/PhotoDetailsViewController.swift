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
    
    private var photoImageView: UIImageView!
    private var scrollView: PhotoZoomableScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

    }
    
    override func buildSubviews() {
        self.view.backgroundColor = UIColor.black
                
        // scrollView.
        self.scrollView = PhotoZoomableScrollView()
        self.scrollView.maximumZoomScale = 10.0
        self.scrollView.minimumZoomScale = 1.0
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints({ (make) in
            make.top.right.bottom.left.equalTo(self.view)
        })
        
        // photoDetailsOpeartionView.
        self.photoDetailsOpeartionView = PhotoDetailsOpeartionView()
        self.view.addSubview(self.photoDetailsOpeartionView)
        self.photoDetailsOpeartionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
    }
    
    override func buildLogic() {
                
        // ViewModel.
        let photoDetailsViewModel = self.viewModel(type:PhotoDetailsViewModel.self)
        
        photoDetailsViewModel?.output.photo.subscribe(onNext: { (photo) in
            self.scrollView.photo = photo
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
