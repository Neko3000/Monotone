//
//  SideMenuProfileCollectionView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/18.
//

import Foundation

import RxSwift
import RxRelay

class SideMenuProfileCollectionView: BaseView{
    
    // MARK: Public
    
    // MARK: Controls
    private var photoContainerView: UIView!
    private var photoAImageView: UIImageView!
    private var photoBImageView: UIImageView!
    private var photoCImageView: UIImageView!
    
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!

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
        super.buildSubviews()
        
        // photoContainerView
        self.photoContainerView = UIView()
        self.addSubview(self.photoContainerView)
        self.photoContainerView.snp.makeConstraints { (make) in
            make.top.right.left.equalTo(self)
        }
        
        // photoAImageView
        self.photoAImageView = UIImageView()
        self.photoAImageView.contentMode = .scaleAspectFill
        self.photoAImageView.backgroundColor = UIColor.blue
        self.photoContainerView.addSubview(self.photoAImageView)
        self.photoAImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.photoContainerView.snp.bottom)
            make.bottom.equalTo(self.photoContainerView.snp.bottom).multipliedBy(1.0/3).offset(-7.0)
            make.right.equalTo(self.photoContainerView.snp.right).multipliedBy(1.0/2).offset(-7.0)
        }
        
        // photoBImageView
        self.photoBImageView = UIImageView()
        self.photoBImageView.contentMode = .scaleAspectFill
        self.photoBImageView.backgroundColor = UIColor.blue
        self.addSubview(self.photoBImageView)
        self.photoContainerView.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(self.photoContainerView.snp.bottom)
            make.top.equalTo(self.photoContainerView.snp.bottom).multipliedBy(2.0/3).offset(7.0)
            make.right.equalTo(self.photoContainerView.snp.right).multipliedBy(1.0/2).offset(-7.0)
        }
        
        // photoCImageView
        self.photoCImageView = UIImageView()
        self.photoCImageView.contentMode = .scaleAspectFill
        self.photoCImageView.backgroundColor = UIColor.blue
        self.photoContainerView.addSubview(self.photoCImageView)
        self.photoCImageView.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(self.photoContainerView.snp.bottom)
            make.left.equalTo(self.photoContainerView.snp.right).multipliedBy(1.0/2).offset(7.0)
        }
        
        // titleLabel
        self.titleLabel = UILabel()
        self.titleLabel.textColor = ColorPalette.colorBlack
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.titleLabel.text = "Misc"
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self.photoContainerView.snp.bottom).offset(7.0)
        }
        
        // descriptionLabel
        self.descriptionLabel = UILabel()
        self.descriptionLabel.textColor = ColorPalette.colorGrayLight
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        self.descriptionLabel.text = "1 photos · Curated by Joan"
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(self)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(7.0)
        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings.

    }
}
