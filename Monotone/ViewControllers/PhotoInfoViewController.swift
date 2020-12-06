//
//  PhotoInfoViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/1.
//

import UIKit

import RxSwift
import Kingfisher

class PhotoInfoViewController: BaseViewController {
    
    // MARK: Controls
    private var pageTitleView: PageTitleView!
    
    private var photoImageView: UIImageView!
    private var photoInfoStatisticsView: PhotoInfoStatisticsView!
    private var photoInfoCameraView: PhotoInfoCameraSettingsView!
    
    // MARK: Private
    private var dateFormatter: DateFormatter{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter
    }
    private let disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        self.view.backgroundColor = UIColor.white
        
        // pageTitleView.
        self.pageTitleView = PageTitleView()
        self.view.addSubview(self.pageTitleView)
        self.pageTitleView.snp.makeConstraints { (make) in
            make.left.equalTo(15.0)
            make.right.equalTo(-15.0)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(40.0)
            make.height.equalTo(50.0)
        }
        
        // photoImageView.
        self.photoImageView = UIImageView()
        self.photoImageView.contentMode = .scaleAspectFill
        self.photoImageView.layer.cornerRadius = 6.0
        self.photoImageView.layer.masksToBounds = true
        self.view.addSubview(self.photoImageView)
        self.photoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.pageTitleView.snp.bottom).offset(30.0)
            make.left.equalTo(15.0)
            make.right.equalTo(self.view.snp.right).multipliedBy(4.0/7)
            make.bottom.equalTo(self.view).multipliedBy(1/2.0)
        }
        
        // photoInfoStatisticsView.
        self.photoInfoStatisticsView = PhotoInfoStatisticsView()
        self.view.addSubview(self.photoInfoStatisticsView)
        self.photoInfoStatisticsView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.photoImageView)
            make.left.equalTo(self.photoImageView.snp.right)
            make.right.equalTo(self.view)
        }
        
        // photoInfoCameraView.
        self.photoInfoCameraView = PhotoInfoCameraSettingsView()
        self.view.addSubview(self.photoInfoCameraView)
        self.photoInfoCameraView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.centerY).offset(20.0)
            make.left.equalTo(self.view).offset(16.0)
            make.right.equalTo(self.view).offset(-16.0)
            make.bottom.equalTo(self.view)
        }
    }
    
    override func buildLogic() {
        
        // ViewModel.
        let photoInfoViewModel = self.viewModel(type: PhotoInfoViewModel.self)!
        
        // Bindings.
        photoInfoViewModel.output.photo.subscribe(onNext: { photo in
            
            // pageTitleView.
            if let altDescription = photo.altDescription{
                let title = altDescription.split(separator: " ").prefix(2).joined(separator: " ").capitalized
                self.pageTitleView.title.accept(title)
            }
            
            if let createdAt = photo.createdAt{
                let subtitle = self.dateFormatter.string(from: createdAt)
                self.pageTitleView.subtitle.accept(subtitle)
            }
            
            // photoImageView.
            self.photoImageView.kf.setImage(with: URL(string: photo.urls?.regular ?? ""),
                                            placeholder: UIImage(blurHash: photo.blurHash ?? "", size: CGSize(width: 10, height: 10)),
                                            options: [.transition(.fade(1.0)), .originalCache(.default)])
        })
        .disposed(by: self.disposeBag)
                
        photoInfoViewModel.output.photo.bind(to: self.photoInfoCameraView.photo)
            .disposed(by: self.disposeBag)
        photoInfoViewModel.output.statistics.bind(to: self.photoInfoStatisticsView.statistics)
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
