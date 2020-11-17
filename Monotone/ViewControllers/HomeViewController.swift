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

class HomeViewController: BaseViewController {
    
    // MARK: Priavte
    private var searchingPhotos: Bool = false
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: Controls
    private var homeJumbotronView: HomeJumbotronView?
    private var homeHeaderView: HomeHeaderView?
        
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        
        // homeHeaderView.
        self.homeHeaderView = HomeHeaderView()
        self.view.addSubview(self.homeHeaderView!)
        self.homeHeaderView!.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.height.equalTo(140.0)
            make.top.equalTo(self.view)
        }
        
        // homeJumbotronView.
        self.homeJumbotronView = HomeJumbotronView()
        self.view.addSubview(self.homeJumbotronView!)
        self.homeJumbotronView!.snp.makeConstraints { (make) in
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
        self.collectionView!.backgroundColor = UIColor.clear
        self.collectionView!.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        self.collectionView!.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.view.addSubview(self.collectionView!)
        self.collectionView!.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view).offset(256.0)
        }
        
        let header = MJRefreshNormalHeader.init()
        header.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        header.lastUpdatedTimeLabel!.font = UIFont.systemFont(ofSize: 10)
        self.collectionView!.mj_header = header
        
        let footer = MJRefreshAutoNormalFooter.init()
        footer.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        self.collectionView!.mj_footer = footer
    }
    
    override func buildLogic() {
        
        // ViewModel.
        let listPhotosViewModel = self.viewModel(type:ListPhotosViewModel.self) as! ListPhotosViewModel
        let searchPhotosViewModel = self.viewModel(type:SearchPhotosViewModel.self) as! SearchPhotosViewModel

        // CollectionView.
        self.homeJumbotronView!.segmentStr
            .bind(to: listPhotosViewModel.input.orderBy)
            .disposed(by: self.disposeBag)
//        self.homeHeaderView!.segmentStr.bind(to: searchPhotoViewModel.input)
        
        Observable.of(listPhotosViewModel.output.photos, searchPhotosViewModel.output.photos)
            .merge()
            .bind(to: self.collectionView!.rx.items(cellIdentifier: "PhotoCollectionViewCell")){
                (row, element, cell) in
                
                let pcell: PhotoCollectionViewCell = cell as! PhotoCollectionViewCell
                pcell.photoImageView!.kf.setImage(with: URL(string: element.urls?.regular ?? ""))
            
            }.disposed(by: self.disposeBag)
        
        self.collectionView!.rx.itemSelected
            .subscribe { (indexPath) in
//                let homeVC = HomeViewController()
//
//                let nav = UINavigationController(rootViewController: homeVC)
//                nav.modalPresentationStyle = .fullScreen
//
//                let vc1 = PhotoDetailsViewController()
//                nav.pushViewController(vc1, animated: true)
//
//                let vc2 = PhotoDetailsViewController()
//                nav.pushViewController(vc2, animated: true)
//
//                UIApplication.shared.keyWindow?.rootViewController = nav
//    //            self.present(nav, animated: true, completion: nil)
            }.disposed(by: self.disposeBag)

        // CollectionView MJRefresh.
        self.collectionView!.mj_header!.refreshingBlock = {
            if(self.searchingPhotos){
                searchPhotosViewModel.input.reloadAction?.execute()
            }
            else{
                listPhotosViewModel.input.reloadAction?.execute()
            }
        }
            
        self.collectionView!.mj_footer!.refreshingBlock = {
            if(self.searchingPhotos){
                searchPhotosViewModel.input.loadMoreAction?.execute()
            }
            else{
                listPhotosViewModel.input.loadMoreAction?.execute()
            }
        }
        
        // MJRefresh style.
        Observable.of(listPhotosViewModel.output.reloading, searchPhotosViewModel.output.reloading)
            .merge()
            .skipWhile({ $0 == true })
            .subscribe { (_) in
                self.collectionView!.mj_header!.endRefreshing()
            } onError: { (error) in
                print("error")
            }
            .disposed(by: self.disposeBag)

        
        Observable.of(listPhotosViewModel.output.loadingMore, searchPhotosViewModel.output.loadingMore)
            .merge()
            .skipWhile({ $0 == true })
            .subscribe { (_) in
                self.collectionView!.mj_footer!.endRefreshing()
            } onError: { (error) in
                print("error")
            }
            .disposed(by: self.disposeBag)
        
        // Animation for homeJumbotronView & homeHeaderView
        self.collectionView!.rx.contentOffset
            .flatMap({ (contentOffset) -> Observable<Bool> in
                return Observable.just( contentOffset.y >= InterfaceGlobalValue.showTopContentOffset )
            })
            .skipWhile({ $0 == false })
            .distinctUntilChanged()
            .subscribe(onNext: { (toShowHeader) in
                self.animateTopView(toShowHeader: toShowHeader)
            })
            .disposed(by: self.disposeBag)
        
        // FiXME: Query.
        listPhotosViewModel.input.orderBy.onNext("popular")
        listPhotosViewModel.input.loadMoreAction?.execute()
    }
    
    // MARK: Animation for homeJumbotronView & homeHeaderView
    func animateTopView(toShowHeader: Bool){
        
        if(toShowHeader){
            anim { (animSettings) -> (animClosure) in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.homeJumbotronView!.alpha = 0
                }
            }
            
            anim(constraintParent: self.view) { (animSettings) -> animClosure in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.homeJumbotronView!.snp.updateConstraints({ (make) in
                        make.top.equalTo(self.view).offset(-100.0)
                    })
                    
                    self.collectionView!.snp.updateConstraints { (make) in
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
                    self.homeJumbotronView!.alpha = 1
                }
            }
            
            anim(constraintParent: self.view) { (animSettings) -> animClosure in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.homeJumbotronView!.snp.updateConstraints({ (make) in
                        make.top.equalTo(self.view)
                    })
                    
                    self.collectionView!.snp.updateConstraints { (make) in
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
        if(indexPath.row % 3 == 0){
            return CGSize(width: self.collectionView!.frame.width, height: 300.0)
        }
        else{
            return CGSize(width: self.collectionView!.frame.width / 2.0, height: 300.0)
        }
    }
}
