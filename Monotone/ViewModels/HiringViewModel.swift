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
        //
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var license: BehaviorRelay<(key:String,value:String)?> = BehaviorRelay<(key:String,value:String)?>(value: nil)
        var manifesto: BehaviorRelay<(key:String,value:String)?> = BehaviorRelay<(key:String,value:String)?>(value: nil)
        var privacyPolicy: BehaviorRelay<(key:String,value:String)?> = BehaviorRelay<(key:String,value:String)?>(value: nil)
        var termsAndConditions: BehaviorRelay<(key:String,value:String)?> = BehaviorRelay<(key:String,value:String)?>(value: nil)
        var apiTerms: BehaviorRelay<(key:String,value:String)?> = BehaviorRelay<(key:String,value:String)?>(value: nil)
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
        self.output.license.accept((key:"License",value:""))
    }
    
}
