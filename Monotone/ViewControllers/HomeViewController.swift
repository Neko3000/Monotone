//
//  HomeViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/2.
//

import UIKit
import MJRefresh

import ObjectMapper
import Kingfisher
import RxSwift

class HomeViewController: BaseViewController, ViewControllerBindable, UICollectionViewDelegateFlowLayout  {
    
    internal var viewModel: ListPhotosViewModel?
    private let disposeBag: DisposeBag = DisposeBag()
    
    private var homeJumbotronView: HomeJumbotronView?
    private var homeHeaderView: HomeHeaderView?
    
    private var collectionView: UICollectionView?
    
    public func bind(to viewModel: ListPhotosViewModel?) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        
        // homeJumbotronView.
        self.homeJumbotronView = HomeJumbotronView()
        self.view.addSubview(self.homeJumbotronView!)
        self.homeJumbotronView!.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(256.0);
        }
        
        // homeHeaderView.
        self.homeHeaderView = HomeHeaderView()
        self.view.addSubview(self.homeHeaderView!)
        self.homeHeaderView!.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(140.0);
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
            make.top.equalTo(self.homeJumbotronView!.snp.bottom)
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
        self.viewModel = ListPhotosViewModel(service: PhotoService())
        
        // CollectionView.
        self.homeJumbotronView!.segmentStr.bind(to: self.viewModel!.input.orderBy).disposed(by: self.disposeBag)
        
        self.viewModel!.output.photos.bind(to: self.collectionView!.rx.items(cellIdentifier: "PhotoCollectionViewCell")){
            (row, element, cell) in
            
            let pcell: PhotoCollectionViewCell = cell as! PhotoCollectionViewCell
            pcell.photoImageView!.kf.setImage(with: URL(string: element.urls?.regular ?? ""))
            
        }.disposed(by: self.disposeBag)
        
        self.collectionView!.rx.itemSelected.subscribe { (indexPath) in
            let homeVC = HomeViewController()
            
            let nav = UINavigationController(rootViewController: homeVC)
            nav.modalPresentationStyle = .fullScreen
            
            let vc1 = PhotoDetailsViewController()
            nav.pushViewController(vc1, animated: true)
            
            let vc2 = PhotoDetailsViewController()
            nav.pushViewController(vc2, animated: true)
            
            UIApplication.shared.keyWindow?.rootViewController = nav
//            self.present(nav, animated: true, completion: nil)
        }.disposed(by: self.disposeBag)

        // CollectionView MJRefresh.
        self.collectionView!.mj_header!.refreshingBlock = {
            self.viewModel?.input.reloadAction?.execute()
        }
            
        self.collectionView!.mj_footer!.refreshingBlock = {
            self.viewModel?.input.loadMoreAction?.execute()
        }
        
        // MJRefresh style.
        self.viewModel!.output.reloading.subscribe(onNext: { (reloading) in
            if(!reloading){
                self.collectionView!.mj_header!.endRefreshing()
            }
        }, onError: { (error) in
            print("error!")
        }).disposed(by: self.disposeBag)
        
        self.viewModel!.output.loadingMore.subscribe(onNext: { (loadingMore) in
            if(!loadingMore){
                self.collectionView!.mj_footer!.endRefreshing()
            }
        }, onError: { (error) in
            print("error!")
        }).disposed(by: self.disposeBag)
        
        // Animation for homeJumbotronView & homeHeaderView
        self.collectionView!.rx.contentOffset.flatMap({ (contentOffset) -> Observable<Bool> in
            return Observable.just( contentOffset.y <= InterfaceGlobalValue.showHeaderContentOffset )
        })
        .distinctUntilChanged()
        .subscribe(onNext: { (toShowHeader) in
            self.switchTopView(toShowHeader: toShowHeader)
        }, onError: { (error) in
            // nothing
        })
        .disposed(by: self.disposeBag)
        
        self.collectionView!.rx.contentOffset.flatMap({ (contentOffset) -> Observable<Bool> in
            return Observable.just( contentOffset.y > InterfaceGlobalValue.showHeaderContentOffset )
        }).bind(to: self.homeJumbotronView!.rx.isHidden)
        .disposed(by: self.disposeBag)
        
        // FiXME: Query.
        self.viewModel?.input.orderBy.onNext("popular")
        self.viewModel?.input.loadMoreAction?.execute()
    }
    
    // MARK: CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.row % 3 == 0){
            return CGSize(width: self.collectionView!.frame.width, height: 300.0)
        }
        else{
            return CGSize(width: self.collectionView!.frame.width / 2.0, height: 300.0)
        }
    }
    
    // MARK: Animation for homeJumbotronView & homeHeaderView
    func switchTopView(toShowHeader: Bool){
        if(toShowHeader){
            
        }
        else{
            
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
