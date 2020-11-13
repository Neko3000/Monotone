//
//  BaseViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/7.
//

import Foundation

import RxSwift
import Action

protocol ViewModelStreamable {
    associatedtype InputType
    associatedtype OutputType
    
    var input: InputType { get }
    var output: OutputType { get }
}

protocol ViewModelBindable {
    func bind()
}

class BaseViewModel: ViewModelBindable{
    var service: NetworkService?
    let disposeBag: DisposeBag = DisposeBag()
    
    init(service: NetworkService) {
        self.service = service
        self.bind()
    }
    
    internal func bind() {
        // Implementated by subclass.
    }
}
