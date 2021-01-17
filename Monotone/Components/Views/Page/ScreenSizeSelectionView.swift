//
//  WallpaperSizeSelectionView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/16.
//

import UIKit

import RxSwift
import RxRelay

// MARK: - WallpaperSizeSelectionView
class WallpaperSizeSelectionView: BaseView {
    
    // MARK: - Public
    public var wallpaperSizes: BehaviorRelay<[WallpaperSize]?> = BehaviorRelay<[WallpaperSize]?>(value: nil)
    public var selectedWallpaperSize: BehaviorRelay<WallpaperSize?> = BehaviorRelay<WallpaperSize?>(value: nil)
    
    // MARK: - Controls
    private var collectionView: UICollectionView!

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func buildSubviews() {
        super.buildSubviews()
        
        // CollectionView
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 8
        flowLayout.scrollDirection = .horizontal
        
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.register(WallpapersHeaderCollectionViewCell.self, forCellWithReuseIdentifier: "WallpapersHeaderCollectionViewCell")
        self.collectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalTo(self)
        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings
        // WallpaperSizes.
        self.wallpaperSizes
            .unwrap()
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
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WallpaperSizeSelectionView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let inset = collectionView.contentInset
        
        let height: CGFloat = collectionView.frame.height - (inset.top + inset.bottom)
        let width: CGFloat = 120.0
        
        return CGSize(width: width, height: height)
    }
}
