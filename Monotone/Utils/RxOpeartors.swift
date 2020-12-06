//
//  RxOpeartors.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/20.
//

import Foundation

import RxSwift
import RxRelay

// MARK: 2-way Binding
infix operator <=> : DefaultPrecedence
func <=> <T: Equatable>(observableA: BehaviorRelay<T>, observableB: BehaviorRelay<T>) -> Disposable {

    let a2bDispose = observableA.bind(to: observableB)
    let b2aDispose = observableB
        .distinctUntilChanged()
        .subscribe(onNext: { n in
            observableA.accept(n)
        }, onCompleted:  {
            a2bDispose.dispose()
        })

    return Disposables.create(a2bDispose, b2aDispose)
}
