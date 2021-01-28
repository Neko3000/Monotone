//
//  PhotoCollectionViewCell.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/9.
//

import UIKit

import RxSwift
import RxRelay
import RxSwiftExt

import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public
    public var photo: BehaviorRelay<Photo?> = BehaviorRelay<Photo?>(value: nil)
        
    // MARK: - Controls
    private var photoImageView: UIImageView!
    private var defaultImageView: UIImageView!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.buildSubviews()
        self.buildLogic()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildSubviews(){
                
        // DefaultImageView.
        self.defaultImageView = UIImageView()
        self.defaultImageView.image = UIImage(named: "unsplash-logo")
        self.contentView.addSubview(self.defaultImageView)
        self.defaultImageView.snp.makeConstraints({ (make) in
            make.center.equalTo(self.contentView)
            make.width.height.equalTo(30.0)
        })
        
        // PhotoImageView.
        self.photoImageView = UIImageView()
        self.photoImageView.contentMode = .scaleAspectFill
        self.photoImageView.layer.masksToBounds = true
        self.contentView.addSubview(self.photoImageView)
        self.photoImageView.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalTo(self.contentView)
        }
        
    }
    
    private func buildLogic(){
        
        // Bindings.
        // Photo.
        self.photo
            .unwrap()
            .subscribe(onNext:{ [weak self] (photo) in
                guard let self = self else { return }
                
                self.photoImageView.setPhoto(photo: photo, size: .regular)
            })
            .disposed(by: self.disposeBag)
    }
}
