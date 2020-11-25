//
//  HomeViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/2.
//

import UIKit

import SnapKit
import MJRefresh
import RxSwift
import Kingfisher
import anim
import ViewAnimator

class HomeViewController: BaseViewController {
    
    // MARK: Priavte
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: Controls
    private var homeJumbotronView: HomeJumbotronView!
    private var homeHeaderView: HomeHeaderView!
        
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
//        let animation = AnimationType.zoom(scale: 0.2)
//        UIView.animate(views: self.collectionView.visibleCells, animations: [animation], reversed: false, initialAlpha: 0, finalAlpha: 1.0, delay: 1.0, animationInterval: 0.8, duration: 0.8, options: .curveEaseInOut, completion: nil)
    }
    
    override func buildSubviews() {
        
        self.view.backgroundColor = ColorPalette.colorWhite
        
        // homeHeaderView.
        self.homeHeaderView = HomeHeaderView()
        self.view.addSubview(self.homeHeaderView)
        self.homeHeaderView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.height.equalTo(140.0)
            make.top.equalTo(self.view)
        }
        
        // homeJumbotronView.
        self.homeJumbotronView = HomeJumbotronView()
        self.view.addSubview(self.homeJumbotronView)
        self.homeJumbotronView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.height.equalTo(256.0)
            make.top.equalTo(self.view)
        }
        
        // collectionView.
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .vertical
        
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        self.collectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view).offset(256.0)
        }
        
        let header = MJRefreshNormalHeader.init()
        header.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        header.lastUpdatedTimeLabel!.font = UIFont.systemFont(ofSize: 10)
        self.collectionView.mj_header = header
        
        let footer = MJRefreshAutoNormalFooter.init()
        footer.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        self.collectionView.mj_footer = footer
    }
    
    override func buildLogic() {
        
        // ViewModel.
        let homeViewModel = self.viewModel(type:HomeViewModel.self)

        // homeJumbotronView & homeHeaderView
        (self.homeJumbotronView.listOrderBy <=> homeViewModel!.input.listOrderBy)
            .disposed(by:self.disposeBag)
        
        (self.homeHeaderView.listOrderBy <=> homeViewModel!.input.listOrderBy)
            .disposed(by:self.disposeBag)
        
        (self.homeHeaderView.searchQuery <=> homeViewModel!.input.searchQuery)
            .disposed(by:self.disposeBag)
        
        (self.homeHeaderView.topic <=> homeViewModel!.input.topic)
            .disposed(by:self.disposeBag)
                
        // CollectionView.
        homeViewModel!.output.photos
            .bind(to: self.collectionView.rx.items(cellIdentifier: "PhotoCollectionViewCell")){
                (row, element, cell) in
                
                let pcell: PhotoCollectionViewCell = cell as! PhotoCollectionViewCell
                pcell.photoImageView!.kf.setImage(with: URL(string: element.urls?.regular ?? ""),
                                                  placeholder: UIImage(blurHash: element.blurHash ?? "", size: CGSize(width: 10, height: 10)),
                                                  options: [.transition(.fade(1.0)), .originalCache(.default)])
            
            }.disposed(by: self.disposeBag)
        
        self.collectionView.rx.itemSelected
            .subscribe { (indexPath) in
                
                self.transition(type: .present(.photoDetails(nil), .fullScreen), with: nil)
                
            }.disposed(by: self.disposeBag)

        // CollectionView MJRefresh.
        self.collectionView.mj_header!.refreshingBlock = {
            homeViewModel!.input.reloadAction?.execute()
        }
            
        self.collectionView.mj_footer!.refreshingBlock = {
            homeViewModel!.input.loadMoreAction?.execute()
        }
        
        // MJRefresh style.
        homeViewModel!.output.reloading
            .skipWhile({ $0 == true })
            .subscribe { (_) in
                self.collectionView.mj_header!.endRefreshing()
            }
            .disposed(by: self.disposeBag)

        
        homeViewModel!.output.loadingMore
            .skipWhile({ $0 == true })
            .subscribe { (_) in
                self.collectionView.mj_footer!.endRefreshing()
            }
            .disposed(by: self.disposeBag)
        
        // Animation for homeJumbotronView & homeHeaderView
        self.collectionView.rx.contentOffset
            .flatMap({ (contentOffset) -> Observable<Bool> in
                return Observable.just( contentOffset.y >= InterfaceGlobalValue.showTopContentOffset )
            })
            .skipWhile({ $0 == false })
            .distinctUntilChanged()
            .subscribe(onNext: { (toShowHeader) in
                self.animateTopView(toShowHeader: toShowHeader)
            })
            .disposed(by: self.disposeBag)
        
        // First Loading - Latest.
        self.homeJumbotronView.listOrderBy.accept("latest")
    }
    
    // MARK: Animation for homeJumbotronView & homeHeaderView
    func animateTopView(toShowHeader: Bool){
        
        if(toShowHeader){
            anim { (animSettings) -> (animClosure) in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.homeJumbotronView.alpha = 0
                }
            }
            
            anim(constraintParent: self.view) { (animSettings) -> animClosure in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.homeJumbotronView.snp.updateConstraints({ (make) in
                        make.height.equalTo(140.0)
                    })
                    
                    self.collectionView.snp.updateConstraints { (make) in
                        make.top.equalTo(self.view).offset(140.0)
                    }
                }
            }
            
        }
        else{
            anim { (animSettings) -> (animClosure) in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.homeJumbotronView.alpha = 1
                }
            }
            
            anim(constraintParent: self.view) { (animSettings) -> animClosure in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.homeJumbotronView.snp.updateConstraints({ (make) in
                        make.height.equalTo(256.0)
                    })
                    
                    self.collectionView.snp.updateConstraints { (make) in
                        make.top.equalTo(self.view).offset(256.0)
                    }
                }
            }
        }
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

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
    // MARK: CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(indexPath.row % 4 == 0 || indexPath.row % 4 == 3 ){
            return CGSize(width: self.collectionView.frame.width, height: 300.0)
        }
        else{
            return CGSize(width: self.collectionView.frame.width / 2.0, height: 300.0)
        }
    }
}
