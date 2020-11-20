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
import RxCocoa

class HomeHeaderView: BaseView {
    
    public let segmentStr: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    public let searchQuery: BehaviorRelay<String> = BehaviorRelay<String>(value: "")

    private var searchTextField: UITextField?
    private var segmentedControl: HMSegmentedControl?
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func buildSubviews() {
        
        // 
        self.backgroundColor = ColorPalette.colorWhite
        
        // searchTextField.
        let searchImageView: UIImageView = UIImageView()
        searchImageView.image = UIImage(named: "header-input-search")
        
        let attributedSearch = NSAttributedString(string: NSLocalizedString("unsplash_home_search", comment: "Search"), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)])
        
        self.searchTextField = MTTextField()
        self.searchTextField!.backgroundColor = ColorPalette.colorGrayLighter
        self.searchTextField!.placeholder = "Search"
        self.searchTextField!.attributedPlaceholder = attributedSearch
        self.searchTextField!.leftView = searchImageView
        self.searchTextField!.leftViewMode = .unlessEditing
        self.searchTextField!.layer.cornerRadius = 4.0
        self.searchTextField!.layer.masksToBounds = true
        self.searchTextField!.returnKeyType = .search
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
        self.segmentedControl!.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.bottom
        self.segmentedControl!.selectionIndicatorColor = ColorPalette.colorBlack
        self.segmentedControl!.selectionIndicatorHeight = 2.0
        self.segmentedControl!.segmentEdgeInset = UIEdgeInsets(top: 0, left: 8.0, bottom: 0, right: 8.0)
        self.segmentedControl!.segmentWidthStyle = HMSegmentedControlSegmentWidthStyle.dynamic
        self.segmentedControl!.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        self.addSubview(self.segmentedControl!)
        self.segmentedControl!.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15.0)
            make.right.equalTo(self).offset(-15.0)
            make.bottom.equalTo(self)
            make.height.equalTo(40.0)
        }
    }
    
    override func buildLogic() {
        
        // searchTextField
        self.searchTextField!.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { (_) in
                self.searchQuery.accept(self.searchTextField!.text ?? "")
            })
            .disposed(by: self.disposeBag)
        
        // segmentedControl
        self.segmentStr
            .flatMap { (segmentStr) -> Observable<Int> in
                let index = self.segmentedControl!.sectionTitles!.firstIndex(of: segmentStr) ?? 0
                return Observable.just(index)
            }
            .subscribe { (index) in
                self.segmentedControl!.setSelectedSegmentIndex(UInt(index), animated: false)
            }
            .disposed(by: self.disposeBag)
    }

    @objc private func segmentedControlChangedValue(segmentedControl: HMSegmentedControl){
        
        let index = Int(segmentedControl.selectedSegmentIndex)
        let title = segmentedControl.sectionTitles![index]

        self.segmentStr.accept(title)
    }
}
