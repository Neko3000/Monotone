//
//  PhotoDetailsViewController.swift
//  
//
//  Created by Xueliang Chen on 2020/11/12.
//

import UIKit

import SnapKit
import RxSwift
import Kingfisher
import anim

class PhotoDetailsViewController: BaseViewController {
    
    // MARK: Priavte
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: Controls
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orange

        // Do any additional setup after loading the view.
    }
    
    override func buildSubviews() {
        
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
