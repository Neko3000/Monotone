//
//  HomeHeaderView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/15.
//

import UIKit

import SnapKit
import HMSegmentedControl

import RxSwift

class HomeHeaderView: BaseView {
    
    public let searchQuery: BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    public let segmentStr: BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    
    private var searchTextField: UITextField?
    private var segmentedControl: HMSegmentedControl?
    
    override func buildSubviews() {
        
        // searchTextField.
        let searchImageView: UIImageView = UIImageView()
        searchImageView.image = UIImage(named: "header-input-search")
        
        self.searchTextField = UITextField()
        self.searchTextField!.backgroundColor = ColorPalette.colorGrayLighter
        self.searchTextField!.placeholder = "Search"
        self.searchTextField!.leftView = searchImageView
        self.searchTextField!.leftViewMode = .unlessEditing
        self.searchTextField!.layer.cornerRadius = 4.0
        self.searchTextField!.layer.masksToBounds = true
        self.addSubview(self.searchTextField!)
        self.searchTextField!.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(16.0)
            make.right.equalTo(self).offset(-16.0)
            make.top.equalTo(self).offset(50.0)
            make.height.equalTo(36.0)
        })
        
        // segmentedControl
        self.segmentedControl = HMSegmentedControl(sectionTitles: [
            NSLocalizedString("unsplash_home_segment_popular", comment: "Popular"),
            NSLocalizedString("unsplash_home_segment_lastest", comment: "Lastest"),
            NSLocalizedString("unsplash_home_segment_lastest", comment: "Lastest"),
        ])
        self.segmentedControl!.titleTextAttributes = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor : ColorPalette.colorGrayNormal
        ]
        self.segmentedControl!.selectedTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor : ColorPalette.colorBlack
        ]
        self.segmentedControl!.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.top
        self.segmentedControl!.selectionIndicatorColor = ColorPalette.colorBlack
        self.segmentedControl!.selectionIndicatorHeight = 1.0
        self.segmentedControl!.segmentWidthStyle = HMSegmentedControlSegmentWidthStyle.dynamic
        self.segmentedControl!.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        self.addSubview(self.segmentedControl!)
        self.segmentedControl!.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(50.0)
        }
    }

    @objc private func segmentedControlChangedValue(segmentedControl: HMSegmentedControl){
        
        let index = Int(segmentedControl.selectedSegmentIndex)
        let title = segmentedControl.sectionTitles![index]

        self.segmentStr.onNext(title)
    }
}
