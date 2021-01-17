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
    public let listOrderBy: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    public let topic: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)

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
        let segmentedValues = UnsplashListOrderBy.allCases.map({ $0.rawValue.title }) + UnsplashTopic.allCases.map({ $0.rawValue.title })
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
        Observable.of(self.listOrderBy, self.topic)
            .merge()
            .distinctUntilChanged()
            .unwrap()
            .flatMap { (key) -> Observable<Int> in
                let segmentedKeys = UnsplashListOrderBy.allCases.map({ $0.rawValue.key }) + UnsplashTopic.allCases.map({ $0.rawValue.key })
                let index = segmentedKeys.firstIndex { $0 == key } ?? -1
                
                return Observable.just(index)
            }
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
        case 0..<UnsplashListOrderBy.allCases.count:
            self.listOrderBy.accept(UnsplashListOrderBy.allCases[index].rawValue.key)
            break
            
        case UnsplashListOrderBy.allCases.count..<UnsplashListOrderBy.allCases.count + UnsplashTopic.allCases.count:
            self.topic.accept(UnsplashTopic.allCases[index - UnsplashListOrderBy.allCases.count].rawValue.key)
            break

        default:
            break
        }
    }
}
