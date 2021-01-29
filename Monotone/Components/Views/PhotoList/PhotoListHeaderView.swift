//
//  PhotoListHeaderView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/15.
//

import UIKit

import SnapKit
import HMSegmentedControl

import RxSwift
import RxCocoa
import RxSwiftExt

class PhotoListHeaderView: BaseView {
    
    // MARK: - Public
    public let searchQuery: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    public let listOrderBy: BehaviorRelay<ListOrderBy?> = BehaviorRelay<ListOrderBy?>(value: nil)
    public let listOrderBys: BehaviorRelay<[ListOrderBy]> = BehaviorRelay<[ListOrderBy]>(value: ListOrderBy.allCases)

    public let topic: BehaviorRelay<UnsplashTopic?> = BehaviorRelay<UnsplashTopic?>(value: nil)
    public let topics: BehaviorRelay<[UnsplashTopic]> = BehaviorRelay<[UnsplashTopic]>(value: UnsplashTopic.allCases)

    // MARK: - Controls
    private var searchTextField: UITextField!
    private var segmentedControl: HMSegmentedControl!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func buildSubviews() {
        super.buildSubviews()
        
        // 
        self.backgroundColor = ColorPalette.colorWhite
        
        // SearchTextField.
        let searchImageView: UIImageView = UIImageView()
        searchImageView.image = UIImage(named: "header-input-search")
        
        let attributedSearch = NSAttributedString(string: NSLocalizedString("uns_home_search", comment: "Search"), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)])
        
        self.searchTextField = MTTextField()
        self.searchTextField.backgroundColor = ColorPalette.colorGrayLighter
        self.searchTextField.placeholder = "Search"
        self.searchTextField.attributedPlaceholder = attributedSearch
        self.searchTextField.leftView = searchImageView
        self.searchTextField.leftViewMode = .unlessEditing
        self.searchTextField.layer.cornerRadius = 4.0
        self.searchTextField.layer.masksToBounds = true
        self.searchTextField.returnKeyType = .search
        self.addSubview(self.searchTextField)
        self.searchTextField.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(16.0)
            make.right.equalTo(self).offset(-16.0)
            make.top.equalTo(self).offset(50.0)
            make.height.equalTo(36.0)
        })
        
        
        // SegmentedControl
        let segments = self.listOrderBys.value.map({ $0.rawValue.title }) + self.topics.value.map({ $0.rawValue.title })
        self.segmentedControl = HMSegmentedControl(sectionTitles: segments)
        self.segmentedControl.backgroundColor = UIColor.clear
        self.segmentedControl.titleTextAttributes = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor : ColorPalette.colorGrayNormal
        ]
        self.segmentedControl.selectedTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor : ColorPalette.colorBlack
        ]
        self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.bottom
        self.segmentedControl.selectionIndicatorColor = ColorPalette.colorBlack
        self.segmentedControl.selectionIndicatorHeight = 1.0
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
        // SearchTextField.
        self.searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
                self.searchQuery.accept(self.searchTextField.text)
            })
            .disposed(by: self.disposeBag)
        
        self.searchQuery
            .bind(to: self.searchTextField.rx.text)
            .disposed(by: self.disposeBag)
        
        // SegmentedControl.
        // ListOrderBy.
        self.listOrderBy
            .distinctUntilChanged()
            .unwrap()
            .map({ [weak self] (listOrderBy) -> Int in
                guard let self = self else { return -1 }
                
                let keys = self.listOrderBys.value.map({ $0.rawValue.key }) + self.topics.value.map({ $0.rawValue.key })
                return keys.firstIndex { $0 == listOrderBy.rawValue.key } ?? -1
            })
            .filter({ !self.segmentedControl.equalToSelectedSegmentIndex(index: $0) })
            .subscribe(onNext: { [weak self] (index) in
                guard let self = self else { return }
                
                self.segmentedControl.setSelectedSegmentIndex(index: index, animated: false)
            })
            .disposed(by: self.disposeBag)
        
        // Topic.
        self.topic
            .distinctUntilChanged()
            .unwrap()
            .map({ [weak self] (topic) -> Int in
                guard let self = self else { return -1 }
                
                let keys = self.listOrderBys.value.map({ $0.rawValue.key }) + self.topics.value.map({ $0.rawValue.key })
                return keys.firstIndex { $0 == topic.rawValue.key } ?? -1
            })
            .filter({ !self.segmentedControl.equalToSelectedSegmentIndex(index: $0) })
            .subscribe(onNext: { [weak self] (index) in
                guard let self = self else { return }
                
                self.segmentedControl.setSelectedSegmentIndex(index: index, animated: false)
            })
            .disposed(by: self.disposeBag)
        
        // SearchQuery.
        self.searchQuery
            .distinctUntilChanged()
            .unwrap()
            .subscribe { [weak self] (value) in
                guard let self = self else { return }
                
                self.listOrderBy.accept(nil)
                self.topic.accept(nil)
            }
            .disposed(by: self.disposeBag)
        
        // ListOrderBy.
        self.listOrderBy
            .distinctUntilChanged()
            .unwrap()
            .subscribe { [weak self] (value) in
                guard let self = self else { return }

                self.searchQuery.accept(nil)
                self.topic.accept(nil)
            }
            .disposed(by: self.disposeBag)
        
        // Topic.
        self.topic
            .distinctUntilChanged()
            .unwrap()
            .subscribe { [weak self] (value) in
                guard let self = self else { return }
                
                self.searchQuery.accept(nil)
                self.listOrderBy.accept(nil)
            }
            .disposed(by: self.disposeBag)
        
//        self.listOrderBy
//            .flatMap { (segmentStr) -> Observable<Int> in
//                let index = self.segmentedControl.sectionTitles!.firstIndex(of: segmentStr) ?? -1
//                return Observable.just(index)
//            }
//            .subscribe(onNext: { (index) in
//                if(index != -1){
//                    self.segmentedControl.setSelectedSegmentIndex(UInt(index), animated: false)
//                }
//            })
//            .disposed(by: self.disposeBag)
    }

    @objc private func segmentedControlChangedValue(segmentedControl: HMSegmentedControl){
        
        let index = Int(segmentedControl.selectedSegmentIndex)
        
        switch index {
        case 0..<self.listOrderBys.value.count:
            self.listOrderBy.accept(self.listOrderBys.value[index])
            break
            
        case self.listOrderBys.value.count..<self.listOrderBys.value.count + self.topics.value.count:
            self.topic.accept(self.topics.value[index - self.listOrderBys.value.count])
            break

        default:
            break
        }
    }
}
