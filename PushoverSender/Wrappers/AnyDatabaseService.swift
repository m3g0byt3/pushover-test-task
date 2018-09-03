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

    // MARK: - Initialization

    init<WrappedService: DatabaseService>(
        _ service: WrappedService
    ) where WrappedService.DatabaseItem == DatabaseItemType {
        self._save = service.save
        self._delete = service.delete
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
}
