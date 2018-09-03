//
//  AnyDatabaseService.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// Type-erasure wrapper for DatabaseService protocol
final class AnyDatabaseService<DatabaseItemType> {

    // MARK: - Properties

    private let _save: (DatabaseItemType) throws -> Void
    private let _delete: (DatabaseItemType) throws -> Void
    // Using full fuction signature here instead of typealias due to compiler crash:
    // `Segmentation fault: 11. While emitting SIL for 'observeChanges(sorted:predicate:completion:)'
    // at /Users/MGBT/Developer/PushoverSender/PushoverSender/Wrappers/AnyDatabaseService.swift:46:5`
    private let _observe: (SortOption?, NSPredicate?, @escaping ([DatabaseItemType], Diff) -> Void) -> Void

    // MARK: - Initialization

    init<WrappedService: DatabaseService>(
        _ service: WrappedService
    ) where WrappedService.DatabaseItem == DatabaseItemType {
        self._save = service.save
        self._delete = service.delete
        self._observe = service.observeChanges
    }
}

// MARK: - DatabaseService protocol conformance

extension AnyDatabaseService: DatabaseService {

    func save(_ object: DatabaseItemType) throws {
        return try _save(object)
    }

    func delete(_ object: DatabaseItemType) throws {
        return try _delete(object)
    }

    func observeChanges(sorted: SortOption?, predicate: NSPredicate?, completion: @escaping Completion) {
        return _observe(sorted, predicate, completion)
    }
}
