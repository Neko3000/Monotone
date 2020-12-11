//
//  UserService.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/7.
//

import Foundation

import ObjectMapper
import RxSwift

class UserService: NetworkService {

    public func listUserCollections(username:String,
                                    page:Int? = 1,
                                    perPage:Int? = 10) -> Observable<[Collection]>{
        let request: ListUserCollectionsRequest = ListUserCollectionsRequest()
        request.username = username
        request.page = page
        request.perPage = perPage
        
        return Observable.create { (observer) -> Disposable in
            
            NetworkManager.shared.request(request: request, method: .get).subscribe { (json) in
                let response = ListUserCollectionsResponse(JSON: json)
                let collections = response!.results!
                
                observer.onNext(collections)
                observer.onCompleted()

            } onError: { (error) in
                
                observer.onError(error)
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
}
