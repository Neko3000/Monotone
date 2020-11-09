//
//  PhotoCollectionViewCell.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/9.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    public var photoImageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.buildSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildSubviews(){
        
        // photoImageView.
        self.photoImageView = UIImageView()
        self.contentView.addSubview(self.photoImageView!)
        self.photoImageView!.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalTo(self.contentView)
        }
    }
}
