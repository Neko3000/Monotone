//
//  PhotoListViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/2.
//

import UIKit

import SnapKit
import MJRefresh
import Kingfisher

import RxSwift
import RxRelay
import RxSwiftExt

import anim
import ViewAnimator

// MARK: - PhotoListViewController
class PhotoListViewController: BaseViewController {
    
    // MARK: - Public
    public let menuBtnPressed: PublishRelay<Void> = PublishRelay<Void>()
    public let searchBtnPressed: PublishRelay<Void> = PublishRelay<Void>()
    
    // MARK: - Controls
    private var jumbotronView: PhotoListJumbotronView!
    private var headerView: PhotoListHeaderView!
        
    private var collectionView: UICollectionView!
    private var toTabBarBtn: UIButton!
    
    // MARK: - Priavte
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
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
        
        // PhotoListHeaderView.
        self.headerView = PhotoListHeaderView()
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.height.equalTo(140.0)
            make.top.equalTo(self.view)
        }
        
        // PhotoListJumbotronView.
        self.jumbotronView = PhotoListJumbotronView()
        self.view.addSubview(self.jumbotronView)
        self.jumbotronView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.height.equalTo(256.0)
            make.top.equalTo(self.view)
        }
        
        // CollectionView.
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
        
        // MJRefresh.
        let header = MJRefreshNormalHeader()
        header.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        header.lastUpdatedTimeLabel!.font = UIFont.systemFont(ofSize: 10)
        self.collectionView.mj_header = header
        
        let footer = MJRefreshAutoNormalFooter()
        footer.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        self.collectionView.mj_footer = footer
        
        // ToTabBarBtn.
        self.toTabBarBtn = UIButton()
        self.toTabBarBtn.setImage(UIImage(named: "to-tabbar-btn"), for: .normal)
        self.view.addSubview(self.toTabBarBtn)
        self.toTabBarBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-30.0);
            make.bottom.equalTo(self.view).offset(-46.0);
        }
    }
    
    override func buildLogic() {
        
        // ViewModel.
        let photoListViewModel = self.viewModel(type:PhotoListViewModel.self)!

        // Bindings.
        // PhotoListJumbotronView & PhotoListHeaderView
        (self.jumbotronView.listOrderBy <=> photoListViewModel.input.listOrderBy)
            .disposed(by:self.disposeBag)
        
        (self.headerView.listOrderBy <=> photoListViewModel.input.listOrderBy)
            .disposed(by:self.disposeBag)
        
        (self.headerView.searchQuery <=> photoListViewModel.input.searchQuery)
            .disposed(by:self.disposeBag)
        
        (self.headerView.topic <=> photoListViewModel.input.topic)
            .disposed(by:self.disposeBag)
                
        // CollectionView.
        photoListViewModel.output.photos
            .bind(to: self.collectionView.rx.items(cellIdentifier: "PhotoCollectionViewCell")){
                (row, element, cell) in
                
                let pcell: PhotoCollectionViewCell = cell as! PhotoCollectionViewCell
                pcell.photoImageView!.kf.setImage(with: URL(string: element.urls?.regular ?? ""),
                                                  placeholder: UIImage(blurHash: element.blurHash ?? "", size: CGSize(width: 10, height: 10)),
                                                  options: [.transition(.fade(0.7)), .originalCache(.default)])
            
            }.disposed(by: self.disposeBag)
        
        self.collectionView.rx.modelSelected(Photo.self)
            .subscribe(onNext:{ [weak self] (photo) in
                guard let self = self else { return }
                
                let args = [
                    "photo" : photo
                ] as [String : Any?]

                self.transition(type: .push(scene: .photoDetails), with: args, animated: true)

            }).disposed(by: self.disposeBag)

        // MJRefresh.
        self.collectionView.mj_header!.refreshingBlock = {
            photoListViewModel.input.reloadAction?.execute()
        }
            
        self.collectionView.mj_footer!.refreshingBlock = {
            photoListViewModel.input.loadMoreAction?.execute()
        }
        
        photoListViewModel.output.reloading
            .ignore(true)
            .subscribe { [weak self] (_) in
                guard let self = self else { return }
                
                self.collectionView.mj_header!.endRefreshing()
            }
            .disposed(by: self.disposeBag)

        photoListViewModel.output.loadingMore
            .ignore(true)
            .subscribe { [weak self] (_) in
                guard let self = self else { return }

                self.collectionView.mj_footer!.endRefreshing()
            }
            .disposed(by: self.disposeBag)
        
        // Animation
        self.collectionView.rx.contentOffset
            .flatMap({ (contentOffset) -> Observable<AnimationState> in
                let animationState: AnimationState = contentOffset.y >= InterfaceGlobalVars.showTopContentOffset ? .showHeaderView : .showJumbotronView
                return Observable.just(animationState)
            })
            .skipWhile({ $0 == .showJumbotronView })
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] (animationState) in
                guard let self = self else { return }
                
                self.animation(animationState: animationState)
            })
            .disposed(by: self.disposeBag)
        
        // ToTabBarBtn.
        self.toTabBarBtn.rx.tap.subscribe(onNext: { (_) in
            SceneCoordinator.shared.transition(type: .present(scene: .tabBar), with: nil, animated: true)
        })
        .disposed(by: self.disposeBag)
        
        // MenuBtnPressed.
        self.jumbotronView.menuBtnPressed
            .bind(to: self.menuBtnPressed)
            .disposed(by: self.disposeBag)
        
        // SearchBtnPressed.
        self.jumbotronView.searchBtnPressed
            .bind(to: self.searchBtnPressed)
            .disposed(by: self.disposeBag)
        
        // First Loading - Latest.
        self.jumbotronView.listOrderBy.accept(.latest)
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
extension PhotoListViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(indexPath.row % 4 == 0 || indexPath.row % 4 == 3 ){
            return CGSize(width: self.collectionView.frame.width, height: 300.0)
        }
        else{
            return CGSize(width: self.collectionView.frame.width / 2.0, height: 300.0)
        }
    }
}

// MARK: - ViewControllerAnimatable
extension PhotoListViewController: ViewControllerAnimatable{
    
    // MARK: - Enums
    enum AnimationState {
        case showJumbotronView
        case showHeaderView
    }
    
    // MARK: - Animation
    // Animation for jumbotronView & headerView
    func animation(animationState: AnimationState) {
        switch animationState {
        case .showHeaderView:
            
            anim { (animSettings) -> (animClosure) in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.jumbotronView.alpha = 0
                }
            }
            
            anim(constraintParent: self.view) { (animSettings) -> animClosure in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.jumbotronView.snp.updateConstraints({ (make) in
                        make.height.equalTo(140.0)
                    })
                    
                    self.collectionView.snp.updateConstraints { (make) in
                        make.top.equalTo(self.view).offset(140.0)
                    }
                }
            }
            
            break
        case .showJumbotronView:
            
            anim { (animSettings) -> (animClosure) in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.jumbotronView.alpha = 1
                }
            }
            
            anim(constraintParent: self.view) { (animSettings) -> animClosure in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    self.jumbotronView.snp.updateConstraints({ (make) in
                        make.height.equalTo(256.0)
                    })
                    
                    self.collectionView.snp.updateConstraints { (make) in
                        make.top.equalTo(self.view).offset(256.0)
                    }
                }
            }
            
            break
        }
    }
}
