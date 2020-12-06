//
//  PhotoInfoCameraSettingsView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/1.
//

import UIKit

import SnapKit
import RxSwift
import RxRelay

class PhotoInfoCameraSettingsView: BaseView {
    
    // MARK: Public
    public var photo: BehaviorRelay<Photo?> = BehaviorRelay<Photo?>(value: nil)
    
    /*
    public var make: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    public var model: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    public var focalLength: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    public var shutterSpeed: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    public var aperture: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    public var iso: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    public var dimensions: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    */

    // MARK: Controls
    private var cameraImageView: UIImageView!
    private var cameraLabel: UILabel!
    
    private var makeLabel: UILabel!
    private var makeContentLabel: UILabel!
    private var modelLabel: UILabel!
    private var modelContentLabel: UILabel!
    private var focalLengthLabel: UILabel!
    private var focalLengthContentLabel: UILabel!
    private var shutterSpeedLabel: UILabel!
    private var shutterSpeedContentLabel: UILabel!
    private var apertureLabel: UILabel!
    private var apertureContentLabel: UILabel!
    private var isoLabel: UILabel!
    private var isoContentLabel: UILabel!
    private var dimensionsLabel: UILabel!
    private var dimensionsContentLabel: UILabel!
    
    // MARK: Private
    private let disposeBag: DisposeBag = DisposeBag()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: - Life Cycle
    override func buildSubviews() {
        super.buildSubviews()
        
        self.cameraImageView = UIImageView()
        self.cameraImageView.image = UIImage(named: "info-camera")
        self.addSubview(self.cameraImageView)
        self.cameraImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30.0)
            make.top.left.equalTo(self)
        }
        
        self.cameraLabel = UILabel()
        self.cameraLabel.text = NSLocalizedString("unsplash_info_camera_settings", comment: "Camera")
        self.cameraLabel.textColor = ColorPalette.colorBlack
        self.cameraLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.addSubview(self.cameraLabel)
        self.cameraLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.cameraImageView)
            make.left.equalTo(self.cameraImageView.snp.right).offset(3.0)
        }
        
        self.makeLabel = UILabel()
        self.makeLabel.text = NSLocalizedString("unsplash_info_camera_settings_make", comment: "Make")
        self.makeLabel.textColor = ColorPalette.colorGrayLight
        self.makeLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(self.makeLabel)
        self.makeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self).multipliedBy(3/7.0)
            make.top.equalTo(self.snp.bottom).multipliedBy(1/5.0)
        }
        
        self.makeContentLabel = UILabel()
        self.makeContentLabel.text = "NIKON CORPORATION"
        self.makeContentLabel.textColor = ColorPalette.colorGrayHeavy
        self.makeContentLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(self.makeContentLabel)
        self.makeContentLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.makeLabel)
            make.top.equalTo(self.makeLabel.snp.bottom).offset(6.0)
        }
        
        self.modelLabel = UILabel()
        self.modelLabel.text = NSLocalizedString("unsplash_info_camera_settings_model", comment: "Model")
        self.modelLabel.textColor = ColorPalette.colorGrayLight
        self.modelLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(self.modelLabel)
        self.modelLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.right).multipliedBy(4/7.0)
            make.top.equalTo(self.snp.bottom).multipliedBy(1/5.0)
        }
        
        self.modelContentLabel = UILabel()
        self.modelContentLabel.text = "NIKON D300"
        self.modelContentLabel.textColor = ColorPalette.colorGrayHeavy
        self.modelContentLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(self.modelContentLabel)
        self.modelContentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.modelLabel)
            make.top.equalTo(self.modelLabel.snp.bottom).offset(6.0)
        }
        
        self.focalLengthLabel = UILabel()
        self.focalLengthLabel.text = NSLocalizedString("unsplash_info_camera_settings_focal_length", comment: "Focal Length")
        self.focalLengthLabel.textColor = ColorPalette.colorGrayLight
        self.focalLengthLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(self.focalLengthLabel)
        self.focalLengthLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self).multipliedBy(3/7.0)
            make.top.equalTo(self.snp.bottom).multipliedBy(2/5.0)
        }
        
        self.focalLengthContentLabel = UILabel()
        self.focalLengthContentLabel.text = "50.0mm"
        self.focalLengthContentLabel.textColor = ColorPalette.colorGrayHeavy
        self.focalLengthContentLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(self.focalLengthContentLabel)
        self.focalLengthContentLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.focalLengthLabel)
            make.top.equalTo(self.focalLengthLabel.snp.bottom).offset(6.0)
        }
        
        self.shutterSpeedLabel = UILabel()
        self.shutterSpeedLabel.text = NSLocalizedString("unsplash_info_camera_settings_shutter_speed", comment: "Shutter Speed")
        self.shutterSpeedLabel.textColor = ColorPalette.colorGrayLight
        self.shutterSpeedLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(self.shutterSpeedLabel)
        self.shutterSpeedLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.right).multipliedBy(4/7.0)
            make.top.equalTo(self.snp.bottom).multipliedBy(2/5.0)
        }
        
        self.shutterSpeedContentLabel = UILabel()
        self.shutterSpeedContentLabel.text = "1/250s"
        self.shutterSpeedContentLabel.textColor = ColorPalette.colorGrayHeavy
        self.shutterSpeedContentLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(self.shutterSpeedContentLabel)
        self.shutterSpeedContentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.shutterSpeedLabel)
            make.top.equalTo(self.shutterSpeedLabel.snp.bottom).offset(6.0)
        }
        
        self.apertureLabel = UILabel()
        self.apertureLabel.text = NSLocalizedString("unsplash_info_camera_settings_aperture", comment: "Aperture")
        self.apertureLabel.textColor = ColorPalette.colorGrayLight
        self.apertureLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(self.apertureLabel)
        self.apertureLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self).multipliedBy(3/7.0)
            make.top.equalTo(self.snp.bottom).multipliedBy(3/5.0)
        }
        
        self.apertureContentLabel = UILabel()
        self.apertureContentLabel.text = "ƒ/5.6"
        self.apertureContentLabel.textColor = ColorPalette.colorGrayHeavy
        self.apertureContentLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(self.apertureContentLabel)
        self.apertureContentLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.apertureLabel)
            make.top.equalTo(self.apertureLabel.snp.bottom).offset(6.0)
        }
        
        self.isoLabel = UILabel()
        self.isoLabel.text = NSLocalizedString("unsplash_info_camera_settings_iso", comment: "ISO")
        self.isoLabel.textColor = ColorPalette.colorGrayLight
        self.isoLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(self.isoLabel)
        self.isoLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.right).multipliedBy(4/7.0)
            make.top.equalTo(self.snp.bottom).multipliedBy(3/5.0)
        }
        
        self.isoContentLabel = UILabel()
        self.isoContentLabel.text = "400"
        self.isoContentLabel.textColor = ColorPalette.colorGrayHeavy
        self.isoContentLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(self.isoContentLabel)
        self.isoContentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.isoLabel)
            make.top.equalTo(self.isoLabel.snp.bottom).offset(6.0)
        }
        
        self.dimensionsLabel = UILabel()
        self.dimensionsLabel.text = NSLocalizedString("unsplash_info_camera_settings_dimensions", comment: "Dimensions")
        self.dimensionsLabel.textColor = ColorPalette.colorGrayLight
        self.dimensionsLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(self.dimensionsLabel)
        self.dimensionsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self).multipliedBy(3/7.0)
            make.top.equalTo(self.snp.bottom).multipliedBy(4/5.0)
        }
        
        self.dimensionsContentLabel = UILabel()
        self.dimensionsContentLabel.text = "2648 × 3310"
        self.dimensionsContentLabel.textColor = ColorPalette.colorGrayHeavy
        self.dimensionsContentLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(self.dimensionsContentLabel)
        self.dimensionsContentLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.dimensionsLabel)
            make.top.equalTo(self.dimensionsLabel.snp.bottom).offset(6.0)
        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings
        self.photo
            .filter({ return $0 != nil })
            .subscribe(onNext: { photo in
                self.makeContentLabel.text = photo?.exif?.make ?? "-"
                self.modelContentLabel.text = photo?.exif?.model ?? "-"
                self.focalLengthContentLabel.text = photo?.exif?.focalLength ?? "-"
                self.shutterSpeedContentLabel.text = photo?.exif?.exposureTime ?? "-"
                self.apertureContentLabel.text = photo?.exif?.aperture ?? "-"
                self.isoContentLabel.text = photo?.exif?.iso ?? "-"
                self.dimensionsContentLabel.text = "\(photo?.width ?? 0) x \(photo?.height ?? 0)"
        })
            .disposed(by: self.disposeBag)
    }

}
