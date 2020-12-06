//
//  PhotoShareViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/4.
//

import Foundation

import RxSwift
import RxRelay
import Action

class PhotoShareViewModel: BaseViewModel, ViewModelStreamable{
    
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
    
    // MARK: - Private

    
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
        
        // Bindings.
        self.input.photo.bind(to: self.output.photo)
            .disposed(by: self.disposeBag)
        
    }
    
}
