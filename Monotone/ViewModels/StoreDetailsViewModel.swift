//
//  StoreDetailsViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/9.
//

import Foundation

import RxSwift
import RxRelay
import Action
import RxSwiftExt

class StoreDetailsViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var storeItem: BehaviorRelay<StoreItem?> = BehaviorRelay<StoreItem?>(value: nil)
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var storeItem: BehaviorRelay<StoreItem?> = BehaviorRelay<StoreItem?>(value: nil)
    }
    public var output: Output = Output()
    
    // MARK: - Private
    //
    
    // MARK: - Inject
    override func inject(args: [String : Any?]?) {
        if let storeItem = args?["storeItem"]{
            self.input.storeItem = BehaviorRelay(value: storeItem as? StoreItem)
        }
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service.
        //
        
        // Bindings.
        self.input.storeItem
            .bind(to: self.output.storeItem)
            .disposed(by: self.disposeBag)
    }
    
}
