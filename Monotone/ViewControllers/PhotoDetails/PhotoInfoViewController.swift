//
//  PhotoInfoViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/1.
//

import UIKit

import RxSwift
import Kingfisher

// MARK: - PhotoDetailsViewController
class PhotoInfoViewController: BaseViewController {
    
    // MARK: - Controls
    private var pageTitleView: PageTitleView!
    
    private var photoImageView: UIImageView!
    private var photoInfoStatisticsView: PhotoInfoStatisticsView!
    private var photoInfoCameraView: PhotoInfoCameraSettingsView!
    
    // MARK: - Private
    private var dateFormatter: DateFormatter{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter
    }
    private let disposeBag: DisposeBag = DisposeBag()
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        super.buildSubviews()

        // 
        self.view.backgroundColor = ColorPalette.colorForeground
        
        // PageTitleView.
        self.pageTitleView = PageTitleView()
        self.view.addSubview(self.pageTitleView)
        self.pageTitleView.snp.makeConstraints { (make) in
            make.left.equalTo(15.0)
            make.right.equalTo(-15.0)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(40.0)
            make.height.equalTo(50.0)
        }
        
        // PhotoImageView.
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
        
        // PhotoInfoStatisticsView.
        self.photoInfoStatisticsView = PhotoInfoStatisticsView()
        self.view.addSubview(self.photoInfoStatisticsView)
        self.photoInfoStatisticsView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.photoImageView)
            make.left.equalTo(self.photoImageView.snp.right)
            make.right.equalTo(self.view)
        }
        
        // PhotoInfoCameraView.
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
        super.buildLogic()
        
        // ViewModel.
        let photoInfoViewModel = self.viewModel(type: PhotoInfoViewModel.self)!
        
        // Bindings.
        // Photo.
        photoInfoViewModel.output.photo
            .unwrap()
            .subscribe(onNext: { [weak self] photo in
                guard let self = self else { return }
            
                // PageTitleView.
                if let altDescription = photo.altDescription{
                    let title = altDescription.split(separator: " ").prefix(2).joined(separator: " ").capitalized
                    self.pageTitleView.title.accept(title)
                }
                
                if let createdAt = photo.createdAt{
                    let subtitle = self.dateFormatter.string(from: createdAt)
                    self.pageTitleView.subtitle.accept(subtitle)
                }
                
                // PhotoImageView.
                self.photoImageView.setPhoto(photo: photo, size: .regular)
            })
            .disposed(by: self.disposeBag)
            
            photoInfoViewModel.output.photo.bind(to: self.photoInfoCameraView.photo)
                .disposed(by: self.disposeBag)
        
            photoInfoViewModel.output.statistics.bind(to: self.photoInfoStatisticsView.statistics)
                .disposed(by: self.disposeBag)
    }
    
}
