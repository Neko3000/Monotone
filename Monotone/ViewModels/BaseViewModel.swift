//
//  BaseViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/7.
//

import Foundation

import RxSwift

// MARK: - ViewModelServable
protocol ViewModelServable {
    init(services: [BaseService]?, args: [String: Any?]?)
    
    var services: [BaseService]? { get }
    func service<T: BaseService>(type: T.Type) -> T?
}

extension ViewModelServable where Self: BaseViewModel{
    
    func service<T>(type: T.Type) -> T? where T : BaseService {
        return self.services?.find(by: type)
    }
}

// MARK: - ViewModelStreamble
protocol ViewModelStreamable {
    associatedtype InputType
    associatedtype OutputType
    
    var input: InputType { get }
    var output: OutputType { get }
}

extension ViewModelStreamable where Self: BaseViewModel{

}

// MARK: - BaseViewModel
class BaseViewModel: ViewModelServable {
    
    let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - ViewModelServable
    var services: [BaseService]?
    
    required init(services: [BaseService]?, args: [String: Any?]? ) {
        self.services = services
        
        self.inject(args: args)
        self.bind()
    }
    
    func inject(args: [String: Any?]?) {
        // Implementated by subclass.
    }
    
    func bind(){
        // Implementated by subclass.
    }
}
