//
//  CollectionService.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/11.
//

import Foundation

import ObjectMapper
import RxSwift

class CollectionService: NetworkService {

    public func createCollection(title: String,
                                 description: String? = "",
                                 isPrivate: Bool? = false) -> Observable<Collection>{
        
        let request: CreateCollectionRequest = CreateCollectionRequest()
        request.title = title
        request.description = description
        request.isPrivate = isPrivate
        
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request , method: .post).subscribe { (json) in
                let response = CreateCollectionResponse(JSON: json)
                let collection = response!.collection!
                
                observer.onNext(collection)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
}
