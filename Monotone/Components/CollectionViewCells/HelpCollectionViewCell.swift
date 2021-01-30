//
//  HelpCollectionViewCell.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/1/7.
//

import UIKit

import RxSwift
import RxRelay
import RxSwiftExt

class HelpCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public
    public var category: BehaviorRelay<(key:String, icon:UIImage, title:String, description:String, count:Int)?> = BehaviorRelay<(key:String, icon:UIImage, title:String, description:String, count:Int)?>(value: nil)
        
    // MARK: - Controls
    public var iconImageView: UIImageView!
    
    public var titleLabel: UILabel!
    public var descriptionLabel: UILabel!
    public var countLabel: UILabel!
    
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
        
        //
        self.backgroundColor = ColorPalette.colorForeground
        self.layer.cornerRadius = 8.0
        
        // TitleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.textColor = ColorPalette.colorBlack
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.titleLabel.textAlignment = .center
        self.titleLabel.numberOfLines = 2
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10.0)
            make.right.equalTo(self).offset(-10.0)
            make.centerY.equalTo(self).offset(-10.0)
        }
        
        // IconImageView.
        self.iconImageView = UIImageView()
        self.iconImageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self.titleLabel.snp.top).offset(-10.0)
        }
        
        // DescriptionLabel.
        self.descriptionLabel = UILabel()
        self.descriptionLabel.textColor = ColorPalette.colorGrayLight
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 10)
        self.descriptionLabel.textAlignment = .center
        self.descriptionLabel.numberOfLines = 4
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10.0)
            make.right.equalTo(self).offset(-10.0)
            make.top.equalTo(self.iconImageView.snp.bottom).offset(48.0)
        }
        
        // CountLabel.
        self.countLabel = UILabel()
        self.countLabel.textColor = ColorPalette.colorGrayLight
        self.countLabel.font = UIFont.systemFont(ofSize: 10)
        self.countLabel.textAlignment = .center
        self.addSubview(self.countLabel)
        self.countLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10.0)
            make.right.equalTo(self).offset(-10.0)
            make.bottom.equalTo(self).offset(-18.0)
        }
    }
    
    private func buildLogic(){
        
        // Bindings.
        // Category.
        self.category
            .unwrap()
            .subscribe(onNext: { [weak self] (category) in
                guard let self = self else { return }

                self.iconImageView.image = category.icon
                self.titleLabel.text = category.title
                self.descriptionLabel.text = category.description
                self.countLabel.text = String(format: NSLocalizedString("uns_help_article_count_suffix", comment: "%d articles in this collection"),
                                              category.count)
            })
            .disposed(by: self.disposeBag)
            
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.applyShadow()
    }
    
    private func applyShadow() {
        // Shadow.
        self.layer.applySketchShadow(color: ColorPalette.colorShadow, alpha: 1.0, x: 0, y: 2.0, blur: 10.0, spread: 0)
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 8.0).cgPath
    }
}
