//
//  CollectionDetailsViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/29.
//

import UIKit

import SnapKit
import MJRefresh

import RxSwift
import RxRelay
import RxSwiftExt
import RxDataSources

import anim
import ViewAnimator

class MyFlowLayout: UICollectionViewFlowLayout{
    
}

// MARK: - CollectionDetailsViewController
class CollectionDetailsViewController: BaseViewController {
    
    // MARK: - Public

    
    // MARK: - Controls
    private var dataSource: RxCollectionViewSectionedReloadDataSource<CollectionDetailsSection>!
    private var collectionView: UICollectionView!
    
    private var topGradientImageView: UIImageView!
    
    // MARK: - Priavte
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func buildSubviews() {
        
        self.view.backgroundColor = ColorPalette.colorWhite
        
        let flowLayout = ElevatorFlowLayout()
        flowLayout.headerReferenceSize = CGSize(width: 300, height: 1300)
        flowLayout.itemSize = CGSize(width: 300, height: 100)
        
        // CollectionView.
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.register(PhotoCollectionViewCell.self,
                                     forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        self.collectionView.register(CollectionDetailsHeaderView.self,
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                     withReuseIdentifier: "CollectionDetailsHeaderView")
        self.collectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(90.0)
        }
        
        // MJRefresh.
        let header = MJRefreshNormalHeader()
        header.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        header.lastUpdatedTimeLabel!.font = UIFont.systemFont(ofSize: 10)
        self.collectionView.mj_header = header
        
        let footer = MJRefreshAutoNormalFooter()
        footer.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        self.collectionView.mj_footer = footer
        
        // TopGradientView.
        self.topGradientImageView = UIImageView()
        self.topGradientImageView.image = UIImage(named: "list-top-gradient")
        self.view.addSubview(self.topGradientImageView)
        self.topGradientImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.collectionView)
            make.right.left.equalTo(self.view)
            make.height.equalTo(92.0)
        }
    }
    
    override func buildLogic() {
        
        // ViewModel.
        let collectionDetailsViewModel = self.viewModel(type:CollectionDetailsViewModel.self)!

        // Bindings.
        // DataSource.
        self.dataSource = RxCollectionViewSectionedReloadDataSource<CollectionDetailsSection>{
            (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
            
            var cell: UICollectionViewCell? = nil
            
            if(indexPath.section == 0){
                let pcell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
                pcell.photo.accept(item)
                
                cell = pcell
            }
            
            return cell!
        }
        
        self.dataSource.configureSupplementaryView = {
            (dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            
            var supplementaryView: UICollectionReusableView? = nil
            
            if(kind == UICollectionView.elementKindSectionHeader){
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionDetailsHeaderView", for: indexPath) as! CollectionDetailsHeaderView
                header.collection.accept(dataSource.sectionModels[indexPath.section].header)
                
                supplementaryView = header
            }
            else if(kind == UICollectionView.elementKindSectionFooter){
                let footer = UICollectionReusableView()
                
                supplementaryView = footer
            }
            else{
                supplementaryView = UICollectionReusableView()
            }
            
            return supplementaryView!
        }
        
        collectionDetailsViewModel.output.sections
            .bind(to: collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)

        // MJRefresh.
        self.collectionView.mj_header!.refreshingBlock = {
            collectionDetailsViewModel.input.reloadAction?.execute()
        }
            
        self.collectionView.mj_footer!.refreshingBlock = {
            collectionDetailsViewModel.input.loadMoreAction?.execute()
        }
        
        collectionDetailsViewModel.output.reloading
            .ignore(true)
            .subscribe { [weak self] (_) in
                guard let self = self else { return }
                
                self.collectionView.mj_header!.endRefreshing()
            }
            .disposed(by: self.disposeBag)

        collectionDetailsViewModel.output.loadingMore
            .ignore(true)
            .subscribe { [weak self] (_) in
                guard let self = self else { return }

                self.collectionView.mj_footer!.endRefreshing()
            }
            .disposed(by: self.disposeBag)
        
        // Model Select.
        self.collectionView.rx.modelSelected(Photo.self)
            .subscribe(onNext:{ [weak self] (photo) in
                guard let self = self else { return }
                
                let args = [
                    "photo" : photo
                ] as [String : Any?]

                self.transition(type: .push(scene: .photoDetails), with: args, animated: true)

            }).disposed(by: self.disposeBag)
        
        // First loading.
        collectionDetailsViewModel.input.loadMoreAction?.execute()
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
extension CollectionDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        if let headerView = collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader).first {
                    // Layout to get the right dimensions
                    headerView.layoutIfNeeded()

                    // Automagically get the right height
                    let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height

                    // return the correct size
                    return CGSize(width: collectionView.frame.width, height: height)
                }

                // You need this because this delegate method will run at least
                // once before the header is available for sizing.
                // Returning zero will stop the delegate from trying to get a supplementary view
                return CGSize(width: 300, height: 300)

    }
    
    
}
