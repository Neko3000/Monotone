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
        //
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var photo: BehaviorRelay<Photo?> = BehaviorRelay<Photo?>(value: nil)
    }
    public var output: Output = Output()
    
    // MARK: - Private

    
    // MARK: - Inject
    override func inject(args: [String : Any?]?) {
        if let photo = args?["photo"]{
            self.output.photo = BehaviorRelay(value: photo as? Photo)
        }
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service.
        //
        
        // Bindings.
        //
    }
    
}
