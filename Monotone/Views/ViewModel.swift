//
//  ViewModelProtocol.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/7.
//

import Foundation

import RxSwift
import Action

protocol ViewModelIOProtocol {
    associatedtype Input
    associatedtype Output
    
    var input:Input { get }
    var output:Output { get }
}

protocol ViewModelBindProtocol {
    func bind()
}

class ViewModel: ViewModelBindProtocol{
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
