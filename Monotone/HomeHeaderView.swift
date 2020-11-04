//
//  HomeHeaderView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/2.
//

import UIKit

import HMSegmentedControl
import SnapKit

class HomeHeaderView: MTView {
    
    private var menuBtn: UIButton?
    private var searchBtn: UIButton?
    private var titleLabel: UILabel?
    private var descriptionLabel: UILabel?
    private var segmentedControl: HMSegmentedControl?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func buildSubviews(){
        
        self.menuBtn = UIButton()
        self.menuBtn!.setImage(UIImage(named: "header-menu"), for: .normal)
        self.addSubview(self.menuBtn!)
        self.menuBtn!.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20.0);
            make.top.equalTo(self).offset(40.0);
            make.width.height.equalTo(36.0)
        }
        
        self.searchBtn = UIButton()
        self.searchBtn!.setImage(UIImage(named: "header-search"), for: .normal)
        self.addSubview(self.searchBtn!)
        self.searchBtn!.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(-20.0);
            make.top.equalTo(self).offset(40.0);
            make.width.height.equalTo(36.0)
        }
        
        self.titleLabel = UILabel()
        self.titleLabel!.text = NSLocalizedString("unsplash_home_title", comment: "Unsplash")
        self.titleLabel!.textColor = MTColorPalette.colorBlack
        self.titleLabel!.font = UIFont.boldSystemFont(ofSize: 36)
        self.addSubview(self.titleLabel!)
        self.titleLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(18.0)
            make.top.equalTo(self).offset(91.0)
        }
        
        let attributedDescription = NSMutableAttributedString(string: NSLocalizedString("unsplash_home_description", comment: "Beautiful, free photos.\nGifted by the world’s most generous community of \nphotographers. 🎁"))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6.0
        
        attributedDescription.addAttribute(NSAttributedString.Key.paragraphStyle,value: paragraphStyle, range: NSMakeRange(0, attributedDescription.length))

        self.descriptionLabel = UILabel()
        self.descriptionLabel!.attributedText = attributedDescription
        self.descriptionLabel!.textColor = MTColorPalette.colorGrayNormal
        self.descriptionLabel!.font = UIFont.systemFont(ofSize: 12)
        self.descriptionLabel!.numberOfLines = 0
        self.addSubview(self.descriptionLabel!)
        self.descriptionLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(18.0)
            make.right.equalTo(self).offset(-18.0)
            make.top.equalTo(self.titleLabel!.snp.bottom).offset(5.0)
            make.bottom.equalTo(self).offset(-60.0)
        }
        
        self.segmentedControl = HMSegmentedControl(sectionTitles: [
            NSLocalizedString("unsplash_home_segment_editoral", comment: "Editoral"),
            NSLocalizedString("unsplash_home_segment_following", comment: "Follwing")
        ])
        self.segmentedControl!.titleTextAttributes = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor : MTColorPalette.colorGrayNormal
        ]
        self.segmentedControl!.selectedTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor : MTColorPalette.colorBlack
        ]
        self.segmentedControl!.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.top
        self.segmentedControl!.selectionIndicatorColor = MTColorPalette.colorBlack
        self.segmentedControl!.selectionIndicatorHeight = 1.0
        self.segmentedControl!.segmentWidthStyle = HMSegmentedControlSegmentWidthStyle.dynamic

        self.addSubview(self.segmentedControl!)
        self.segmentedControl!.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self)
            make.height.equalTo(38.0)
            make.width.equalTo(self).multipliedBy(1.0/3)
        }
        
    }
    
}
