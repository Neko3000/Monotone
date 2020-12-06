//
//  PhotoDetailsViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/23.
//

import Foundation

import RxSwift
import RxRelay
import Action

class PhotoDetailsViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var photo: BehaviorRelay<Photo> = BehaviorRelay<Photo>(value: Photo())
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var photo: BehaviorRelay<Photo> = BehaviorRelay<Photo>(value: Photo())
    }
    public var output: Output = Output()
    
    // MARK: Private

    
    // MARK: - Inject
    override func inject(args: [String : Any]?) {
        if(args?["photo"] != nil){
            self.input.photo = BehaviorRelay(value: args!["photo"] as! Photo)
        }
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service.
        //
        
        // Binding.
        (self.input.photo <=> self.output.photo)
            .disposed(by: self.disposeBag)
    }
    
    
}
