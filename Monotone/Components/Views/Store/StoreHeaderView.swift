//
//  StoreHeaderView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/10.
//

import UIKit

import SnapKit
import HMSegmentedControl

import RxSwift
import RxCocoa
import RxSwiftExt

class StoreHeaderView: BaseView {
    
    // MARK: - Public
    public let selectedCategory: BehaviorRelay<StoreCategory?> = BehaviorRelay<StoreCategory?>(value: nil)

    // MARK: - Controls
    private var titleLabel: UILabel!
    private var segmentedControl: HMSegmentedControl!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func buildSubviews() {
        super.buildSubviews()
        
        // 
        
        // TitleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.textColor = ColorPalette.colorBlack
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        self.titleLabel.text = NSLocalizedString("uns_store_title", comment: "Unsplash Store")
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(16.0)
            make.right.equalTo(self).offset(-16.0)
        })
        
        // SegmentedControl.
        let segmentedValues = StoreCategory.allCases.map({ $0.rawValue.title })
        self.segmentedControl = HMSegmentedControl(sectionTitles: segmentedValues)
        self.segmentedControl.titleTextAttributes = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor : ColorPalette.colorGrayNormal
        ]
        self.segmentedControl.selectedTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor : ColorPalette.colorBlack
        ]
        self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.bottom
        self.segmentedControl.selectionIndicatorColor = ColorPalette.colorBlack
        self.segmentedControl.selectionIndicatorHeight = 2.0
        self.segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 8.0, bottom: 0, right: 8.0)
        self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyle.dynamic
        self.segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        self.addSubview(self.segmentedControl)
        self.segmentedControl.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15.0)
            make.right.equalTo(self).offset(-15.0)
            make.bottom.equalTo(self)
            make.height.equalTo(40.0)
        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings.
        // SegmentedControl.
        self.selectedCategory
            .distinctUntilChanged()
            .unwrap()
            .flatMap { (selectedCategory) -> Observable<Int> in
                let index = StoreCategory.allCases.firstIndex { $0 == selectedCategory } ?? -1
                
                return Observable.just(index)
            }
            .filter({ NSDecimalNumber(value: $0) !=  NSDecimalNumber(value: self.segmentedControl.selectedSegmentIndex) })
            .subscribe(onNext: { [weak self] (index) in
                guard let self = self else { return }
                
                self.segmentedControl.setSelectedSegmentIndex(index == -1 ? HMSegmentedControlNoSegment : UInt(index), animated: false)
            })
            .disposed(by: self.disposeBag)
    }

    @objc private func segmentedControlChangedValue(segmentedControl: HMSegmentedControl){
        
        let index = Int(segmentedControl.selectedSegmentIndex)
        
        switch index {
        case 0..<StoreCategory.allCases.count:
            self.selectedCategory.accept(StoreCategory.allCases[index])
            break

        default:
            break
        }
    }
}
