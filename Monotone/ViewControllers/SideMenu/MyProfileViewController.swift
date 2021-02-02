//
//  MyProfileViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/31.
//

import UIKit

import SnapKit
import MJRefresh

import RxSwift
import RxRelay
import RxSwiftExt

import anim
import ViewAnimator

// MARK: - MyProfileViewController
class MyProfileViewController: BaseViewController {
    
    // MARK: - Public
    public var animationState: BehaviorRelay<AnimationState> = BehaviorRelay<AnimationState>(value: .showHeaderDetails)
    
    // MARK: - Controls
    private var headerView: MyProfileHeaderView!
    
    private var photosCollectionView: UICollectionView!
    private var collectionsTableView: UITableView!
    private var likedPhotosCollectionView: UICollectionView!
    
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
        super.buildSubviews()
        
        //
        self.view.backgroundColor = ColorPalette.colorWhite
        
        // HeaderView.
        self.headerView = MyProfileHeaderView()
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view).multipliedBy(1/2.0)
        }
        
        // PhotosCollectionView.
        self.photosCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: ElevatorFlowLayout())
        self.photosCollectionView.backgroundColor = UIColor.clear
        self.photosCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        self.photosCollectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.view.addSubview(self.photosCollectionView)
        self.photosCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom).offset(24.0)
            make.left.right.bottom.equalTo(self.view)
        }
        
        // PhotosCollectionView MJRefresh.
        let photosHeader = MJRefreshNormalHeader()
        photosHeader.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        photosHeader.lastUpdatedTimeLabel!.font = UIFont.systemFont(ofSize: 10)
        self.photosCollectionView.mj_header = photosHeader
        
        let photosFooter = MJRefreshAutoNormalFooter()
        photosFooter.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        self.photosCollectionView.mj_footer = photosFooter
        
        // CollectionsTableView.
        self.collectionsTableView = UITableView(frame: CGRect.zero, style: .grouped)
        self.collectionsTableView.backgroundColor = UIColor.clear
        self.collectionsTableView.separatorStyle = .none
        self.collectionsTableView.showsVerticalScrollIndicator = false
        self.collectionsTableView.register(CollectionsTableViewCell.self, forCellReuseIdentifier: "CollectionsTableViewCell")
        self.collectionsTableView.estimatedSectionHeaderHeight = 172.0
        self.collectionsTableView.sectionHeaderHeight = UITableView.automaticDimension
        self.collectionsTableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.view.addSubview(self.collectionsTableView)
        self.collectionsTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom).offset(24.0)
            make.left.right.bottom.equalTo(self.view)
        }
        
        // CollectionsTableView MJRefresh.
        let collectionsHeader = MJRefreshNormalHeader()
        collectionsHeader.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        collectionsHeader.lastUpdatedTimeLabel!.font = UIFont.systemFont(ofSize: 10)
        self.collectionsTableView.mj_header = collectionsHeader
        
        let collectionsFooter = MJRefreshAutoNormalFooter()
        collectionsFooter.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        self.collectionsTableView.mj_footer = collectionsFooter
        
        // LikePhotosCollectionsView.
        self.likedPhotosCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: ElevatorFlowLayout())
        self.likedPhotosCollectionView.backgroundColor = UIColor.clear
        self.likedPhotosCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        self.likedPhotosCollectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.view.addSubview(self.likedPhotosCollectionView)
        self.likedPhotosCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom).offset(24.0)
            make.left.right.bottom.equalTo(self.view)
        }
        
        // LikePhotosCollectionsView MJRefresh.
        let likedPhotosHeader = MJRefreshNormalHeader()
        likedPhotosHeader.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        likedPhotosHeader.lastUpdatedTimeLabel!.font = UIFont.systemFont(ofSize: 10)
        self.likedPhotosCollectionView.mj_header = likedPhotosHeader
        
        let likedPhotosFooter = MJRefreshAutoNormalFooter()
        likedPhotosFooter.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        self.likedPhotosCollectionView.mj_footer = likedPhotosFooter
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // ViewModel.
        let myProfileViewModel = self.viewModel(type:MyProfileViewModel.self)!

        // Bindings.
        // PhotosCollectionView.
        myProfileViewModel.output.photos
            .bind(to: self.photosCollectionView.rx.items(cellIdentifier: "PhotoCollectionViewCell")){
                (row, element, cell) in
                
                let pcell: PhotoCollectionViewCell = cell as! PhotoCollectionViewCell
                pcell.photo.accept(element)
            
            }.disposed(by: self.disposeBag)
        
        self.photosCollectionView.rx.modelSelected(Photo.self)
            .subscribe(onNext:{ [weak self] (photo) in
                guard let self = self else { return }
                
                let args = [
                    "photo" : photo
                ] as [String : Any?]

                self.transition(type: .push(scene: .photoDetails), with: args, animated: true)

            }).disposed(by: self.disposeBag)

        // PhotosCollectionView MJRefresh.
        self.photosCollectionView.mj_header!.refreshingBlock = {
            myProfileViewModel.input.reloadAction?.execute()
        }
            
        self.photosCollectionView.mj_footer!.refreshingBlock = {
            myProfileViewModel.input.loadMoreAction?.execute()
        }
        
        // CollectionsTableView.
        myProfileViewModel.output.collections
            .bind(to: self.collectionsTableView.rx.items(cellIdentifier: "CollectionsTableViewCell")){
                (row, element, cell) in
                
                let pcell: CollectionsTableViewCell = cell as! CollectionsTableViewCell
                pcell.alignToRight = !(row % 2 == 0)
                pcell.collection.accept(element)
            
            }
            .disposed(by: self.disposeBag)
        
        self.collectionsTableView.rx.modelSelected(Collection.self)
            .subscribe(onNext:{ [weak self] (collection) in
                guard let self = self else { return }
                
                let args = [
                    "collection" : collection
                ] as [String : Any?]

                self.transition(type: .push(scene: .collectionDetails), with: args, animated: true)

            }).disposed(by: self.disposeBag)

        // CollectionsTableView MJRefresh.
        self.collectionsTableView.mj_header!.refreshingBlock = {
            myProfileViewModel.input.reloadAction?.execute()
        }
            
        self.collectionsTableView.mj_footer!.refreshingBlock = {
            myProfileViewModel.input.loadMoreAction?.execute()
        }
        
        // LikedPhotosCollectionView.
        myProfileViewModel.output.likedPhotos
            .bind(to: self.likedPhotosCollectionView.rx.items(cellIdentifier: "PhotoCollectionViewCell")){
                (row, element, cell) in
                
                let pcell: PhotoCollectionViewCell = cell as! PhotoCollectionViewCell
                pcell.photo.accept(element)
            
            }.disposed(by: self.disposeBag)
        
        self.likedPhotosCollectionView.rx.modelSelected(Photo.self)
            .subscribe(onNext:{ [weak self] (photo) in
                guard let self = self else { return }
                
                let args = [
                    "photo" : photo
                ] as [String : Any?]

                self.transition(type: .push(scene: .photoDetails), with: args, animated: true)

            }).disposed(by: self.disposeBag)

        // LikedPhotosCollectionView MJRefresh.
        self.likedPhotosCollectionView.mj_header!.refreshingBlock = {
            myProfileViewModel.input.reloadAction?.execute()
        }
            
        self.likedPhotosCollectionView.mj_footer!.refreshingBlock = {
            myProfileViewModel.input.loadMoreAction?.execute()
        }
        
        // Reloading & LoadingMore.
        myProfileViewModel.output.reloading
            .ignore(true)
            .subscribe { [weak self] (_) in
                guard let self = self else { return }
                
                self.photosCollectionView.mj_header!.endRefreshing()
                self.collectionsTableView.mj_header!.endRefreshing()
                self.likedPhotosCollectionView.mj_header!.endRefreshing()
            }
            .disposed(by: self.disposeBag)

        myProfileViewModel.output.loadingMore
            .ignore(true)
            .subscribe { [weak self] (_) in
                guard let self = self else { return }

                self.photosCollectionView.mj_header!.endRefreshing()
                self.collectionsTableView.mj_header!.endRefreshing()
                self.likedPhotosCollectionView.mj_header!.endRefreshing()
            }
            .disposed(by: self.disposeBag)
        
        // ProfileContent.
        self.headerView.profileContent
            .subscribe(onNext:{ [weak self] (profileContent) in
                guard let self = self else { return }
                
                if(profileContent == .photos){
                    self.photosCollectionView.isHidden = false
                    self.collectionsTableView.isHidden = true
                    self.likedPhotosCollectionView.isHidden = true
                }
                else if(profileContent == .collections){
                    self.photosCollectionView.isHidden = true
                    self.collectionsTableView.isHidden = false
                    self.likedPhotosCollectionView.isHidden = true
                }
                else if(profileContent == .likedPhotos){
                    self.photosCollectionView.isHidden = true
                    self.collectionsTableView.isHidden = true
                    self.likedPhotosCollectionView.isHidden = false
                }
                
                myProfileViewModel.input.profileContent.accept(profileContent)
                myProfileViewModel.input.reloadAction?.execute()
            })
            .disposed(by: self.disposeBag)
        
        // User.
        myProfileViewModel.output.user
            .bind(to: self.headerView.user)
            .disposed(by: self.disposeBag)
        
        // Statistics.
        myProfileViewModel.output.statistics
            .bind(to: self.headerView.statistics)
            .disposed(by: self.disposeBag)
        
        // First Loading.
        self.headerView.profileContent.accept(.photos)
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
extension MyProfileViewController: UICollectionViewDelegateFlowLayout{
    //
}

// MARK: - UITableViewDelegate
extension MyProfileViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 252.0
    }
}

// MARK: - ViewControllerAnimatable
extension MyProfileViewController: ViewControllerAnimatable{
    
    // MARK: - Enums
    enum AnimationState {
        case showHeaderDetails
        case showHeaderSummary
    }
    
    // MARK: - BuildAnimation
    @objc func buildAnimation() {
        
        // AnimationState.
        self.animationState
            .skipWhile({ $0 == .showHeaderDetails })
            .distinctUntilChanged()
            .subscribe(onNext:{ [weak self] (animationState) in
                guard let self = self else { return }

                self.animation(animationState: animationState)
            })
            .disposed(by: self.disposeBag)
        
        // ProfileContent & PhotosCollectionView & CollectionsTableView & LikedPhotosCollectionView.
        Observable.combineLatest(self.headerView.profileContent,
                                 self.photosCollectionView.rx.contentOffset,
                                 self.collectionsTableView.rx.contentOffset,
                                 self.likedPhotosCollectionView.rx.contentOffset)
            .subscribe(onNext: { (profileContent, photosContentOffset, collectionsContentOffset, likedPhotosContentOffset) in
                
                var animationState: AnimationState = .showHeaderDetails
                if(profileContent == .photos){
                    animationState = photosContentOffset.y >= InterfaceValues.showTopContentOffset ? .showHeaderSummary : .showHeaderDetails
                }
                else if(profileContent == .collections){
                    animationState = collectionsContentOffset.y >= InterfaceValues.showTopContentOffset ? .showHeaderSummary : .showHeaderDetails
                }
                else if(profileContent == .likedPhotos){
                    animationState = likedPhotosContentOffset.y >= InterfaceValues.showTopContentOffset ? .showHeaderSummary : .showHeaderDetails
                }
                
                self.animationState.accept(animationState)
            })
            .disposed(by: self.disposeBag)
    }
        
    // MARK: - Animation
    func animation(animationState: AnimationState) {
        switch animationState {
        case .showHeaderDetails:
            
            self.headerView.animationState.accept(.showDetails)
            
            anim(constraintParent: self.view) { (animSettings) -> animClosure in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {
                    
                    self.headerView.snp.remakeConstraints { (make) in
                        make.top.equalTo(self.view.safeAreaLayoutGuide)
                        make.left.right.equalTo(self.view)
                        make.bottom.equalTo(self.view).multipliedBy(1/2.0)
                    }
                }
            }
            
            break
            
        case .showHeaderSummary:
            
            self.headerView.animationState.accept(.showSummary)
            
            anim(constraintParent: self.view) { (animSettings) -> animClosure in
                animSettings.duration = 0.5
                animSettings.ease = .easeInOutQuart
                
                return {

                    self.headerView.snp.remakeConstraints { (make) in
                        make.top.equalTo(self.view.safeAreaLayoutGuide)
                        make.left.right.equalTo(self.view)
                        make.bottom.equalTo(self.view).multipliedBy(1/4.0)
                    }
                }
            }
            
            break
        }
    }
}

// MARK: - ViewControllerWithAnimator
extension MyProfileViewController: ViewControllerWithAnimator{
    
    @objc func buildAnimator() {
        
        // AnimatorTrigger.
        AnimatorTrigger.float(views: [
            self.photosCollectionView
        ],
        direction: .toTop)
    }
}



