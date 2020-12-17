//
//  PhotoAddToCollectionViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/4.
//

import UIKit

import RxSwift
import RxRelay
import RxCocoa
import Kingfisher
import MJRefresh

// MARK: - PhotoAddToCollectionViewController
class PhotoAddToCollectionViewController: BaseViewController {
    
    // MARK: - Controls
    private var pageTitleView: PageTitleView!

    private var tableView: UITableView!
    private var createCollectionBtn: UIButton!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func buildSubviews() {
        self.view.backgroundColor = UIColor.white
        
        // pageTitleView.
        self.pageTitleView = PageTitleView()
        self.view.addSubview(self.pageTitleView)
        self.pageTitleView.snp.makeConstraints { (make) in
            make.left.equalTo(15.0)
            make.right.equalTo(-15.0)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(40.0)
            make.height.equalTo(50.0)
        }
        
        // tableView.
        self.tableView = UITableView()
        self.tableView.separatorStyle = .none
        self.tableView.register(AddToCollectionTableViewCell.self, forCellReuseIdentifier: "AddToCollectionTableViewCell")
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.pageTitleView.snp.bottom).offset(21.0)
            make.bottom.equalTo(self.view).offset(-96.0)
        }
        
        // createCollectionBtn.
        self.createCollectionBtn = UIButton()
        self.createCollectionBtn.backgroundColor = ColorPalette.colorGrayLighter
        self.createCollectionBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.createCollectionBtn.setTitleColor(ColorPalette.colorGrayLight, for: .normal)
        self.createCollectionBtn.setTitle(NSLocalizedString("unsplash_add_collection_button_create", comment: "Create a new collection"), for: .normal)
        self.view.addSubview(self.createCollectionBtn)
        self.createCollectionBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(17.0)
            make.right.equalTo(self.view).offset(-17.0)
            make.top.equalTo(self.tableView.snp.bottom).offset(20.0)
            make.height.equalTo(50.0)
        }
        
        // MJRefresh.
        let header = MJRefreshNormalHeader()
        header.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        header.lastUpdatedTimeLabel!.font = UIFont.systemFont(ofSize: 10)
        self.tableView.mj_header = header
        
        let footer = MJRefreshAutoNormalFooter()
        footer.stateLabel!.font = UIFont.systemFont(ofSize: 12)
        self.tableView.mj_footer = footer
    }
    
    override func buildLogic() {
        
        // ViewModel.
        let photoAddToCollectionViewModel = self.viewModel(type: PhotoAddToCollectionViewModel.self)!
        
        // Bindings.
        // tableView cell.
        photoAddToCollectionViewModel.output.collections
            .bind(to: self.tableView.rx.items(cellIdentifier: "AddToCollectionTableViewCell")){
                (row, element, cell) in
                
                let pcell: AddToCollectionTableViewCell = cell as! AddToCollectionTableViewCell
                pcell.collection.accept(element)
                
                if let currentUserCollections = photoAddToCollectionViewModel.input.photo.value?.currentUserCollections{
                    if(currentUserCollections.contains(element)){
                        pcell.displayState.accept(.containsPhoto)
                    }
                    else{
                        pcell.displayState.accept(.notContainsPhoto)
                    }
                }
            }
            .disposed(by: self.disposeBag)
        
        // tableView didSelect.
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                
                let pcell = self.tableView.cellForRow(at: indexPath) as! AddToCollectionTableViewCell
                
                if(pcell.displayState.value == .notContainsPhoto){
                    photoAddToCollectionViewModel.input.collection.accept(pcell.collection.value)
                    photoAddToCollectionViewModel.input.addToCollectionAction?.execute()
                    
                    pcell.loading.accept(true)
                    self.tableView.allowsSelection = false
                }
                else if(pcell.displayState.value == .containsPhoto){
                    photoAddToCollectionViewModel.input.collection.accept(pcell.collection.value)
                    photoAddToCollectionViewModel.input.removeFromCollectionAction?.execute()
                    
                    pcell.loading.accept(true)
                    self.tableView.allowsSelection = false
                }
                
            })
            .disposed(by: disposeBag)
        
        // After reloaded collections.
        photoAddToCollectionViewModel.output.reloading
            .ignore(true)
            .subscribe { [weak self] (_) in
                guard let self = self else { return }

                self.tableView.mj_header!.endRefreshing()
                
                // Scroll to top.
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
            .disposed(by: self.disposeBag)

        // After loaded more collections.
        photoAddToCollectionViewModel.output.loadingMore
            .ignore(true)
            .subscribe { [weak self] (_) in
                guard let self = self else { return }
                
                self.tableView.mj_footer!.endRefreshing()
            }
            .disposed(by: self.disposeBag)
        
        // After adding or removing, hidden activity indicator in the selected cell.
        Observable.of(photoAddToCollectionViewModel.output.addingToCollection,
                      photoAddToCollectionViewModel.output.removingFromCollection)
            .merge()
            .ignore(true)
            .filter({ (_) in self.tableView.indexPathForSelectedRow != nil})
            .subscribe( onNext: { [weak self] (_) in
                guard let self = self else { return }
                
                if let selectedIndexPath = self.tableView.indexPathForSelectedRow{
                    let pcell = self.tableView.cellForRow(at: selectedIndexPath) as! AddToCollectionTableViewCell
                    pcell.loading.accept(false)
                }

                self.tableView.allowsSelection = true
            })
            .disposed(by: self.disposeBag)
        
        // After adding photo to a collection, switch selected cell's state.
        photoAddToCollectionViewModel.output.addedPhoto
            .filter({ (_) in self.tableView.indexPathForSelectedRow != nil })
            .subscribe( onNext: { [weak self] (photo) in
                guard let self = self else { return }
                
                if let selectedIndexPath = self.tableView.indexPathForSelectedRow{
                    let pcell = self.tableView.cellForRow(at: selectedIndexPath) as! AddToCollectionTableViewCell
                    if(photo != nil){
                        pcell.displayState.accept(.containsPhoto)
                    }
                }
            
                self.tableView.allowsSelection = true
            })
            .disposed(by: self.disposeBag)
        
        // After removing photo to a collection, switch selected cell's state.
        photoAddToCollectionViewModel.output.removedPhoto
            .filter({ (_) in self.tableView.indexPathForSelectedRow != nil })
            .subscribe( onNext: { [weak self] (photo) in
                guard let self = self else { return }
                
                if let selectedIndexPath = self.tableView.indexPathForSelectedRow{
                    let pcell = self.tableView.cellForRow(at: selectedIndexPath) as! AddToCollectionTableViewCell
                    if(photo != nil){
                        pcell.displayState.accept(.notContainsPhoto)
                    }
                }
                
                self.tableView.allowsSelection = true
            })
            .disposed(by: self.disposeBag)
        
        // pageTitleView.
        self.pageTitleView.title.accept(NSLocalizedString("unsplash_add_collection_title", comment: "Add to collection"))
        
        // MJRefresh.
        self.tableView.mj_header!.refreshingBlock = {
            photoAddToCollectionViewModel.input.reloadAction?.execute()
        }
            
        self.tableView.mj_footer!.refreshingBlock = {
            photoAddToCollectionViewModel.input.loadMoreAction?.execute()
        }
        
        // createCollectionBtn.
        self.createCollectionBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }

            self.transition(type: .present(.photoCreateCollection(nil), .pageSheet), with: nil, animated: true)
        })
        .disposed(by: self.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // First Loading.
         self.tableView.mj_header?.beginRefreshing()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Create dashed border for createCollectionBtn.
        self.createCollectionBtn.applyDashedBorder(color: ColorPalette.colorGrayLight, cornerRadius: 8.0)
    }
}

// MARK: - UITableViewDelegate
extension PhotoAddToCollectionViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94.0
    }
}

// MARK: - ViewControllerPresentable
extension PhotoAddToCollectionViewController: ViewControllerPresentable{
    
    func didDismissPresentingViewController(presentationController: UIPresentationController?) {
        
        // Reload collections when the presented view controller dismissed.
        self.tableView.mj_header?.beginRefreshing()
    }
}
