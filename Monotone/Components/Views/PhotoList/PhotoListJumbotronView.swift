//
//  PhotoListJumbotronView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/2.
//

import UIKit

import HMSegmentedControl
import SnapKit

import RxSwift
import RxRelay
import RxSwiftExt

class PhotoListJumbotronView: BaseView {
    
    // MARK: - Public
    public let listOrderBy: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    public let menuBtnPressed: PublishRelay<Void> = PublishRelay<Void>()
    public let searchBtnPressed: PublishRelay<Void> = PublishRelay<Void>()
    
    // MARK: - Controls
    private var menuBtn: UIButton!
    private var searchBtn: UIButton!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    
    private var segmentedControl: HMSegmentedControl!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: - Life Cycle
    override func buildSubviews(){
        super.buildSubviews()
        
        // 
        self.backgroundColor = ColorPalette.colorWhite
        
        // MenuBtn.
        self.menuBtn = UIButton()
        self.menuBtn.setImage(UIImage(named: "header-menu"), for: .normal)
        self.addSubview(self.menuBtn)
        self.menuBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20.0);
            make.top.equalTo(self).offset(40.0);
            make.width.height.equalTo(36.0)
        }
        
        // SearchBtn.
        self.searchBtn = UIButton()
        self.searchBtn.setImage(UIImage(named: "header-search"), for: .normal)
        self.addSubview(self.searchBtn)
        self.searchBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(-20.0);
            make.top.equalTo(self).offset(40.0);
            make.width.height.equalTo(36.0)
        }
        
        // TitleLabel.
        self.titleLabel = UILabel()
        self.titleLabel.text = NSLocalizedString("uns_home_title", comment: "Unsplash")
        self.titleLabel.textColor = ColorPalette.colorBlack
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(18.0)
            make.top.equalTo(self).offset(91.0)
        }
        
        // DescriptionLabel.
        let attributedDescription = NSMutableAttributedString(string: NSLocalizedString("uns_home_description", comment: "Beautiful, free photos.\nGifted by the world’s most generous community of \nphotographers. 🎁"))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6.0
        
        attributedDescription.addAttribute(NSAttributedString.Key.paragraphStyle,
                                           value: paragraphStyle,
                                           range: NSMakeRange(0, attributedDescription.length))

        self.descriptionLabel = UILabel()
        self.descriptionLabel.attributedText = attributedDescription
        self.descriptionLabel.textColor = ColorPalette.colorGrayNormal
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        self.descriptionLabel.numberOfLines = 0
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(18.0)
            make.right.equalTo(self).offset(-18.0)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5.0)
            make.bottom.equalTo(self).offset(-60.0)
        }
        
        // SegmentedControl.
        let text: String = UnsplashListOrderBy.allCases.map { $0.rawValue.title }.joined()
        let textSize = text.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0)])
        
        self.segmentedControl = HMSegmentedControl(sectionTitles: UnsplashListOrderBy.allCases.map({ $0.rawValue.title }))
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
        // SegmentedControl.
        self.listOrderBy
            .unwrap()
            .flatMap { (key) -> Observable<Int> in
                let segmentedKeys = UnsplashListOrderBy.allCases.map({ $0.rawValue.key })
                let index = segmentedKeys.firstIndex { $0 == key } ?? -1
                
                return Observable.just(index)
            }
            .filter({ !self.segmentedControl.equalToSelectedSegmentIndex(index: $0) })
            .subscribe(onNext: {[weak self] (index) in
                guard let self = self else { return }
                
                self.segmentedControl.setSelectedSegmentIndex(index: index, animated: false)
            })
            .disposed(by: self.disposeBag)
        
        // MenuBtn.
        self.menuBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            
            self.menuBtnPressed.accept(Void())
        })
        .disposed(by: self.disposeBag)
        
        // SearchBtn.
        self.searchBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            
            self.searchBtnPressed.accept(Void())
        })
        .disposed(by: self.disposeBag)
    }
    
    @objc private func segmentedControlChangedValue(segmentedControl: HMSegmentedControl){
        
        let index = Int(segmentedControl.selectedSegmentIndex)

        switch index {
        case 0..<UnsplashListOrderBy.allCases.count:
            self.listOrderBy.accept(UnsplashListOrderBy.allCases[index].rawValue.key)
            break

        default:
            break
        }
    }
    
}
