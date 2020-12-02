//
//  PhotoInfoCameraView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/1.
//

import UIKit

import SnapKit
import RxSwift
import RxRelay

class PhotoInfoCameraView: BaseView {
    
    // MARK: Public
    public var make: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    public var model: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    public var focalLength: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    public var shutterSpeed: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    public var aperture: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    public var iso: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")
    public var dimensions: BehaviorRelay<String?> = BehaviorRelay<String?>(value: "")

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
    
    override func buildSubviews() {
        self.cameraImageView = UIImageView()
        self.cameraImageView.image = UIImage(named: "info-camera")
        self.addSubview(self.cameraImageView)
        self.cameraImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30.0)
            make.top.left.equalTo(self)
        }
        
        self.cameraLabel = UILabel()
        self.cameraLabel.text = "Camera"
        self.cameraLabel.textColor = ColorPalette.colorBlack
        self.cameraLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.addSubview(self.cameraLabel)
        self.cameraLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.cameraImageView)
            make.left.equalTo(self.cameraImageView.snp.right).offset(3.0)
        }
        
        self.makeLabel = UILabel()
        self.makeLabel.text = "Make"
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
        self.modelLabel.text = "Model"
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
        self.focalLengthLabel.text = "Focal Length"
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
        
    }
    
    override func buildLogic() {
        
        // Bindings
        self.make.bind(to: self.makeLabel.rx.text).disposed(by: self.disposeBag)
        self.model.bind(to: self.modelLabel.rx.text).disposed(by: self.disposeBag)
        self.focalLength.bind(to: self.focalLengthLabel.rx.text).disposed(by: self.disposeBag)
        self.shutterSpeed.bind(to: self.shutterSpeedLabel.rx.text).disposed(by: self.disposeBag)
        self.aperture.bind(to: self.apertureLabel.rx.text).disposed(by: self.disposeBag)
        self.iso.bind(to: self.isoLabel.rx.text).disposed(by: self.disposeBag)
        self.dimensions.bind(to: self.dimensionsLabel.rx.text).disposed(by: self.disposeBag)

    }

}
