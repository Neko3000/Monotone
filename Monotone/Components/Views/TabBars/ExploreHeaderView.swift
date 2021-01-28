//
//  ExploreHeaderView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/24.
//

import UIKit

import SnapKit
import HMSegmentedControl

import RxSwift
import RxCocoa
import RxSwiftExt

class ExploreHeaderView: BaseView {
    
    // MARK: - Public
    public let explore: BehaviorRelay<UnsplashExplore?> = BehaviorRelay<UnsplashExplore?>(value: nil)
    public let explores: BehaviorRelay<[UnsplashExplore]> = BehaviorRelay<[UnsplashExplore]>(value: UnsplashExplore.allCases)

    // MARK: - Controls
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    
    private var segmentedControl: HMSegmentedControl!

    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func buildSubviews() {
        super.buildSubviews()
        
        // 
        self.backgroundColor = ColorPalette.colorWhite
        
        // TitleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        self.titleLabel.textColor = ColorPalette.colorBlack
        self.titleLabel.text = NSLocalizedString("uns_explore_photos_title", comment: "Explore")
        self.titleLabel.numberOfLines = 0
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(18.0)
            make.right.equalTo(self).offset(-18.0)
        }
        
        // DescriptionLabel.
        self.descriptionLabel = UILabel()
        self.descriptionLabel.textColor = ColorPalette.colorGrayLight
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        self.descriptionLabel.text = NSLocalizedString("uns_explore_photos_description", comment: "All photos are free to download and use under the  Unsplash License.")
        self.descriptionLabel.numberOfLines = 0
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(6.0)
            make.left.equalTo(self).offset(18.0)
            make.right.equalTo(self).offset(-18.0)
        }
        
        // SegmentedControl.
        let text: String = UnsplashListOrderBy.allCases.map { $0.rawValue.title }.joined()
        let textSize = text.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0)])
        
        let segments = self.explores.value.map({ $0.rawValue.title })
        self.segmentedControl = HMSegmentedControl(sectionTitles: segments)
        self.segmentedControl.titleTextAttributes = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor : ColorPalette.colorGrayNormal
        ]
        self.segmentedControl.selectedTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor : ColorPalette.colorBlack
        ]
        self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.top
        self.segmentedControl.selectionIndicatorColor = ColorPalette.colorBlack
        self.segmentedControl.selectionIndicatorHeight = 1.0
        self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyle.dynamic
        self.segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        self.addSubview(self.segmentedControl)
        self.segmentedControl.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self)
            make.height.equalTo(38.0)
            make.width.equalTo(textSize.width + 50.0)
        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings.
        // Explore.
        self.explore
            .distinctUntilChanged()
            .unwrap()
            .map({ [weak self] (explore) -> Int in
                guard let self = self else { return -1 }
                
                let keys = self.explores.value.map({ $0.rawValue.key })
                return keys.firstIndex { $0 == explore.rawValue.key } ?? -1
            })
            .filter({ !self.segmentedControl.equalToSelectedSegmentIndex(index: $0) })
            .subscribe(onNext: { [weak self] (index) in
                guard let self = self else { return }
                
                self.segmentedControl.setSelectedSegmentIndex(index: index, animated: false)
            })
            .disposed(by: self.disposeBag)
        
        self.explore
            .unwrap()
            .subscribe(onNext:{ [weak self] (explore) in
                guard let self = self else { return }
                
                if(explore == .explore){
                    self.titleLabel.text = NSLocalizedString("uns_explore_photos_title", comment: "Explore")
                    self.descriptionLabel.text = NSLocalizedString("uns_explore_photos_description", comment: "All photos are free to download and use under the  Unsplash License.")
                }
                else if(explore == .popular){
                    self.titleLabel.text = NSLocalizedString("uns_explore_collections_title", comment: "Collections")
                    self.descriptionLabel.text = NSLocalizedString("uns_explore_collections_description", comment: "Explore the world through collections of beautiful HD pictures free to use under the Unsplash License.")
                }
            })
            .disposed(by: self.disposeBag)
    }

    @objc private func segmentedControlChangedValue(segmentedControl: HMSegmentedControl){
        
        let index = Int(segmentedControl.selectedSegmentIndex)
        
        switch index {
        case 0..<self.explores.value.count:
            self.explore.accept(self.explores.value[index])
            break
        default:
            break
        }
    }
}
