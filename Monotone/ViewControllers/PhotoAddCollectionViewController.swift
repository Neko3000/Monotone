//
//  PhotoAddCollectionViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/4.
//

import UIKit

import RxSwift
import RxRelay
import RxCocoa
import Kingfisher

// MARK: - PhotoAddCollectionViewController
class PhotoAddCollectionViewController: BaseViewController {
    
    // MARK: - Controls
    private var pageTitleView: PageTitleView!

    private var tableView: UITableView!
    private var createCollectionBtn: UIButton!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()

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
    
    // MARK: - Life Cycle
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
        self.tableView.register(AddCollectionTableViewCell.self, forCellReuseIdentifier: "AddCollectionTableViewCell")
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(17.0)
            make.right.equalTo(self.view).offset(-17.0)
            make.top.equalTo(self.pageTitleView.snp.bottom).offset(21.0)
            make.bottom.equalTo(self.view).offset(-96.0)
        }
        
        // addCollectionBtn.
        self.createCollectionBtn = UIButton()
        self.createCollectionBtn.backgroundColor = ColorPalette.colorGrayLighter
        self.createCollectionBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.createCollectionBtn.setTitleColor(ColorPalette.colorGrayLight, for: .normal)
        self.createCollectionBtn.setTitle("Create a new collection", for: .normal)
        self.view.addSubview(self.createCollectionBtn)
        self.createCollectionBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.tableView)
            make.top.equalTo(self.tableView.snp.bottom).offset(20.0)
            make.height.equalTo(50.0)
        }
    }
    
    override func buildLogic() {
        
        // ViewModel.
        let photoAddCollectionViewModel = self.viewModel(type: PhotoAddCollectionViewModel.self)!
        
        // Bindings.
        
        // pageTitleView.
        self.pageTitleView.title.accept(NSLocalizedString("unsplash_add_collection_title", comment: "Add to collection"))
        
        photoAddCollectionViewModel.output.collections
            .bind(to: self.tableView.rx.items(cellIdentifier: "AddCollectionTableViewCell")){
                (row, element, cell) in
                
                let pcell: AddCollectionTableViewCell = cell as! AddCollectionTableViewCell
                pcell.collection.accept(element)
            }
            .disposed(by: self.disposeBag)
            
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Create dashed border for createCollectionBtn.
        self.createCollectionBtn.applyDashedBorder(color: ColorPalette.colorGrayLight, cornerRadius: 8.0)
    }
}

// MARK: - UITableViewDelegate
extension PhotoAddCollectionViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94.0
    }
}
