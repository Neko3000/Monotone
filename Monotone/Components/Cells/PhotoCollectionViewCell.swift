//
//  PhotoCollectionViewCell.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/9.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    public var photoImageView: UIImageView!
    public var defaultImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.buildSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildSubviews(){
        
        // defaultImageView.
        self.defaultImageView = UIImageView()
        self.defaultImageView.image = UIImage(named: "unsplash-logo")
        self.contentView.addSubview(self.defaultImageView)
        self.defaultImageView.snp.makeConstraints({ (make) in
            make.center.equalTo(self.contentView)
            make.width.height.equalTo(30.0)
        })
        
        // photoImageView.
        self.photoImageView = UIImageView()
        self.photoImageView.contentMode = .scaleAspectFill
        self.photoImageView.layer.masksToBounds = true
        self.contentView.addSubview(self.photoImageView)
        self.photoImageView.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalTo(self.contentView)
        }
        
    }
}
