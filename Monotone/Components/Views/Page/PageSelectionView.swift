//
//  PageSelectionView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/1.
//

import UIKit

import RxSwift
import RxRelay

// MARK: - PageSelectionView
class PageSelectionView: BaseView {
    
    // MARK: - Public
    public var items: BehaviorRelay<[(key:Any,value:String)]?> = BehaviorRelay<[(key:Any,value:String)]?>(value: nil)
    public var selectedItem: BehaviorRelay<(key:Any,value:String)?> = BehaviorRelay<(key:Any,value:String)?>(value: nil)
    
    // MARK: - Controls
    private var tableView: UITableView!

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
        
        // TableView.
        self.tableView = UITableView()
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .none
        self.tableView.register(PageSelectionTableViewCell.self, forCellReuseIdentifier: "PageSelectionTableViewCell")
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings
        // Pages.
        self.items
            .unwrap()
            .bind(to: self.tableView.rx.items(cellIdentifier: "PageSelectionTableViewCell")){
                (row, element, cell) in
                
                let pcell: PageSelectionTableViewCell = cell as! PageSelectionTableViewCell
                pcell.item.accept(element)

            }
            .disposed(by: self.disposeBag)
        
        // SelectedPage.
        self.tableView.rx.modelSelected((key:Any,value:String).self)
            .subscribe(onNext:{ [weak self] (item) in
                guard let self = self else { return }
                
                self.selectedItem.accept(item)
            })
            .disposed(by: self.disposeBag)
        
        // ReloadData.
        self.tableView.rx.methodInvoked(#selector(UITableView.reloadData))
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                
                if(self.tableView.numberOfSections > 0 && self.tableView.numberOfRows(inSection: 0) > 0){
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    self.tableView.delegate?.tableView?(self.tableView, didSelectRowAt: indexPath)
                }
            })
            .disposed(by: self.disposeBag)
        
    }
}

// MARK: - UITableViewDelegate
extension PageSelectionView: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49.0
    }
}
