//
//  NetworkServiceProtocol.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/7.
//

import Foundation
import RxSwift

protocol NetworkServiceProtocol {
    var disposeBag: DisposeBag  { get }
}

class NetworkService: NetworkServiceProtocol{
    internal let disposeBag: DisposeBag = DisposeBag()
}
