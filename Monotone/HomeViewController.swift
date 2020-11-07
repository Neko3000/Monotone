//
//  HomeViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/2.
//

import UIKit
import MJRefresh

class HomeViewController: MTViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {

    private var homeHeaderView : HomeHeaderView?
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
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(256.0);
        }
        
        // collectionView.
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .vertical
        
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        self.view.addSubview(self.collectionView!)
        self.collectionView!.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.homeHeaderView!.snp.bottom)
        }
    }
    
    // MARK: CollectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.row % 3 == 0){
            return CGSize(width: self.collectionView!.frame.width, height: 300.0)
        }
        else{
            return CGSize(width: self.collectionView!.frame.width / 2.0, height: 300.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView!.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        
        if(indexPath.row % 3 == 0){
            cell.backgroundColor = UIColor.purple
        }
        else if(indexPath.row % 2 == 0){
            cell.backgroundColor = UIColor.magenta
        }
        else{
            cell.backgroundColor = UIColor.orange
        }
        
        return cell
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
