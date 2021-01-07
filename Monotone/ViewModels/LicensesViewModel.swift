//
//  LicensesViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/23.
//

import Foundation

import RxSwift
import RxRelay
import Action
import RxSwiftExt



class LicensesViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var aggrements: BehaviorRelay<[UnsplashAgreement]?> = BehaviorRelay<[UnsplashAgreement]?>(value: nil)
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var aggrements: BehaviorRelay<[UnsplashAgreement]?> = BehaviorRelay<[UnsplashAgreement]?>(value: nil)
    }
    public var output: Output = Output()
    
    // MARK: - Private
    //
    
    // MARK: - Inject
    override func inject(args: [String : Any?]?) {
        //
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service.
        //
        
        // Bindings.
        self.input.aggrements
            .bind(to: self.output.aggrements)
            .disposed(by: self.disposeBag)
    }
    
}
