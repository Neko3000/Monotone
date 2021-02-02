//
//  HelpViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/1/6.
//

import UIKit

import SnapKit
import MJRefresh

import RxSwift
import RxRelay
import RxSwiftExt

// MARK: - HelpViewController
class HelpViewController: BaseViewController {
    
    // MARK: - Public

    
    // MARK: - Controls
    private var headerView: HelpHeaderView!
    private var headerBackgroundView: UIView!
    
    private var collectionView: UICollectionView!
    
    // MARK: - Priavte
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        super.buildSubviews()
        
        // NavBar.
        self.navBarTransparent = true
        self.navBarItemsColor = UIColor.white
        
        self.view.backgroundColor = ColorPalette.colorWhite
        
        // HeaderView.
        self.headerView = HelpHeaderView()
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.right.left.equalTo(self.view)
            make.height.equalTo(238.0)
        }
        
        // HeaderBackgroundView.
        self.headerBackgroundView = UIView()
        self.headerBackgroundView.backgroundColor = UIColor.black
        self.view.insertSubview(self.headerBackgroundView, belowSubview: self.headerView)
        self.headerBackgroundView.snp.makeConstraints { (make) in
            make.top.right.left.equalTo(self.view)
            make.bottom.equalTo(self.headerView)
        }

        // CollectionView.
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.minimumLineSpacing = 22.0
        flowLayout.scrollDirection = .vertical
        
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.contentInset = UIEdgeInsets(top: 34.0, left: 24.0, bottom: 34.0, right: 24.0)
        self.collectionView.register(HelpCollectionViewCell.self, forCellWithReuseIdentifier: "HelpCollectionViewCell")
        self.collectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.headerView.snp.bottom)
        }
        
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // ViewModel.
        let helpViewModel = self.viewModel(type: HelpViewModel.self)!
        
        // Bindings.
        // UnsplashHelpCategory.
        helpViewModel.input.categories.accept(UnsplashHelpCategory.allCases)
        
        // CollectionView.
        helpViewModel.input.categories
            .unwrap()
            .bind(to: self.collectionView.rx.items(cellIdentifier: "HelpCollectionViewCell")){
                (row, element, cell) in
                
                let pcell: HelpCollectionViewCell = cell as! HelpCollectionViewCell
                pcell.category.accept(element.rawValue)
            
            }.disposed(by: self.disposeBag)
        
        //
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UICollectionViewDelegateFlowLayout
extension HelpViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let columnCount = 2

        let inset = collectionView.contentInset
        let flowLayout: UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let height: CGFloat = 206.0
        let width: CGFloat = (collectionView.frame.width - (inset.left + inset.right) - flowLayout.minimumInteritemSpacing * CGFloat(columnCount - 1)) / CGFloat(columnCount)
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - ViewControllerWithAnimator
extension HelpViewController: ViewControllerWithAnimator{
    
    @objc func buildAnimator() {
        
        // AnimatorTrigger.
        AnimatorTrigger.float(views: [
            self.collectionView
        ],
        direction: .toLeft)
    }
}
