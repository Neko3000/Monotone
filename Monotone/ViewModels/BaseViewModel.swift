//
//  BaseViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/7.
//

import Foundation

import RxSwift
import Action

protocol ViewModelBindable {
    func bind()
}

protocol ViewModelStreamable {
    associatedtype InputType
    associatedtype OutputType
    
    var input: InputType { get }
    var output: OutputType { get }
}

class BaseViewModel: ViewModelBindable {
    var service: NetworkService?
    let disposeBag: DisposeBag = DisposeBag()
    
    init(service: NetworkService) {
        self.service = service
        
        self.bind()
    }
    
    convenience init(service: NetworkService, args: [String: Any]?) {
        self.init(service: service)
        
        self.inject(args:args)
        self.bind()
    }
    
    internal func inject(args: [String: Any]?) {
        // Implementated by subclass.
    }
    
    internal func bind() {
        // Implementated by subclass.
    }
}
