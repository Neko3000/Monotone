//
//  UITableView+Notification.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/2.
//

import Foundation
import RxCocoa
import RxSwift

// https://github.com/RxSwiftCommunity/RxDataSources/issues/183
// by leviathan commented on Dec 13, 2017
extension UITableView {

    /// Reactive wrapper for `UITableView.insertRows(at:with:)`
    var insertRowsEvent: ControlEvent<[IndexPath]> {
        let source = rx.methodInvoked(#selector(UITableView.insertRows(at:with:)))
                .map { a in
                    return a[0] as! [IndexPath]
                }
        return ControlEvent(events: source)
    }

    /// Reactive wrapper for `UITableView.endUpdates()`
    var endUpdatesEvent: ControlEvent<Bool> {
        let source = rx.methodInvoked(#selector(UITableView.endUpdates))
                .map { _ in
                    return true
                }
        return ControlEvent(events: source)
    }

    /// Reactive wrapper for when the `UITableView` inserted rows and ended its updates.
    var insertedItems: ControlEvent<[IndexPath]> {
        let insertEnded = Observable.combineLatest(
                insertRowsEvent.asObservable(),
                endUpdatesEvent.asObservable(),
                resultSelector: { (insertedRows: $0, endUpdates: $1) }
        )
        let source = insertEnded.map { $0.insertedRows }
        return ControlEvent(events: source)
    }
}
