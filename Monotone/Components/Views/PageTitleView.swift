//
//  PageTitleView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/1.
//

import UIKit

class PageTitleView: BaseView {
    
    // MARK: Controls
    private var titleLabel: UILabel!
    private var dateLabel: UILabel!
    
    private var horizontalLineLong: UIView!
    private var horizontalLineShort: UIView!

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func buildSubviews() {
        
        self.titleLabel = UILabel()
        self.titleLabel.textColor = ColorPalette.colorBlack
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        self.titleLabel.text = "Building West"
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
        }
        
        self.dateLabel = UILabel()
        self.dateLabel.textColor = ColorPalette.colorGrayLight
        self.dateLabel.font = UIFont.systemFont(ofSize: 12)
        self.dateLabel.text = "Published on November 28, 2018."
        self.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(5.0)
            make.right.equalTo(self)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(4.0)
            make.bottom.equalTo(self)
        }
        
        self.horizontalLineShort = UIView()
        self.horizontalLineShort.backgroundColor = ColorPalette.colorBlack
        self.addSubview(self.horizontalLineShort)
        self.horizontalLineShort.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.titleLabel)
            make.right.equalTo(self)
            make.width.equalTo(8.0)
            make.height.equalTo(1.0)
        }
        
        self.horizontalLineLong = UIView()
        self.horizontalLineLong.backgroundColor = ColorPalette.colorBlack
        self.addSubview(self.horizontalLineLong)
        self.horizontalLineLong.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.titleLabel)
            make.left.equalTo(self.titleLabel.snp.right).offset(28.0)
            make.right.equalTo(self.horizontalLineShort.snp.left).offset(-8.0)
            make.height.equalTo(1.0)
            make.width.greaterThanOrEqualTo(10.0)
        }
        
    }

    override func buildLogic() {
        
    }
}
