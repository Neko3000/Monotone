//
//  WallpapersHeaderView.swift
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

class WallpapersHeaderView: BaseView {
    
    // MARK: - Public
    public var wallpaperSizes: BehaviorRelay<[WallpaperSize]> = BehaviorRelay<[WallpaperSize]>(value: WallpaperSize.allCases)
    public var selectedWallpaperSize: BehaviorRelay<WallpaperSize> = BehaviorRelay<WallpaperSize>(value: .all)

    // MARK: - Controls
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    
    private var collectionView: UICollectionView!
    
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
        self.titleLabel.textColor = ColorPalette.colorBlack
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        self.titleLabel.text = NSLocalizedString("uns_wallpapers_title", comment: "HD Wallpapers")
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(18.0)
            make.right.equalTo(self).offset(-118.0)
        })
        
        // DescriptionLabel.
        self.descriptionLabel = UILabel()
        self.descriptionLabel.textColor = ColorPalette.colorGrayLight
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        self.descriptionLabel.text = NSLocalizedString("uns_wallpapers_description", comment: "Free HD wallpapers for your mobile and desktop screens.")
        self.descriptionLabel.numberOfLines = 0
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.left.equalTo(self).offset(18.0)
            make.right.equalTo(self).offset(-118.0)
        }
        
        // CollectionView
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 15.0
        flowLayout.scrollDirection = .horizontal
        
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 15.0, bottom: 0, right: 15.0)
        self.collectionView.register(WallpapersHeaderCollectionViewCell.self, forCellWithReuseIdentifier: "WallpapersHeaderCollectionViewCell")
        self.collectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(20.0)
            make.right.left.equalTo(self)
            make.height.equalTo(89.0)
        }
        
        // SegmentedControl.
        self.segmentedControl = HMSegmentedControl()
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
            make.top.equalTo(self.collectionView.snp.bottom).offset(20.0)
            make.left.equalTo(self).offset(15.0)
            make.right.equalTo(self).offset(-15.0)
            make.bottom.equalTo(self)
            make.height.equalTo(40.0)
        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings.
        // WallpaperSizes.
        self.wallpaperSizes
            .subscribe(onNext:{ [weak self] (wallpaperSizes) in
                guard let self = self else { return }

                self.segmentedControl.sectionTitles = wallpaperSizes.map({ $0.rawValue.title })
            })
            .disposed(by: self.disposeBag)
        
        self.wallpaperSizes
            .bind(to: self.collectionView.rx.items(cellIdentifier: "WallpapersHeaderCollectionViewCell")){
                (row, element, cell) in
                
                let pcell: WallpapersHeaderCollectionViewCell = cell as! WallpapersHeaderCollectionViewCell
                pcell.wallpaperSize.accept(element)
            }
            .disposed(by: self.disposeBag)
        
        // SelectedWallpaperSize.
        self.collectionView.rx.modelSelected(WallpaperSize.self)
            .subscribe(onNext:{ [weak self] (wallpaperSize) in
                guard let self = self else { return }
                
                self.selectedWallpaperSize.accept(wallpaperSize)
            })
            .disposed(by: self.disposeBag)
        
        // SegmentedControl.
        self.selectedWallpaperSize
            .distinctUntilChanged()
            .map { [weak self] (wallpaperSize) -> Int in
                guard let self = self else { return -1 }
                
                return self.wallpaperSizes.value.firstIndex { $0 == wallpaperSize } ?? -1
            }
            .filter({ !self.segmentedControl.equalToSelectedSegmentIndex(index: $0) })
            .subscribe(onNext: { [weak self] (index) in
                guard let self = self else { return }
                
                self.segmentedControl.setSelectedSegmentIndex(index: index, animated: false)
            })
            .disposed(by: self.disposeBag)
    }

    @objc private func segmentedControlChangedValue(segmentedControl: HMSegmentedControl){
        
        let index = Int(segmentedControl.selectedSegmentIndex)
        
        switch index {
        case 0..<self.wallpaperSizes.value.count:
            self.selectedWallpaperSize.accept(self.wallpaperSizes.value[index])
            break

        default:
            break
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WallpapersHeaderView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let inset = collectionView.contentInset
        
        let height: CGFloat = collectionView.frame.height - (inset.top + inset.bottom)
        let width: CGFloat = 120.0
        
        return CGSize(width: width, height: height)
    }
}
