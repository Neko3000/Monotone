//
//  BaseViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/7.
//

import Foundation

import RxSwift
import Action

protocol ViewModelIOProtocol {
    associatedtype InputType
    associatedtype OutputType
    
    var input: InputType { get }
    var output: OutputType { get }
}

protocol ViewModelBindProtocol {
    func bind()
}

class BaseViewModel: ViewModelBindProtocol{
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
