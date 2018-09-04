//
//  DatabaseService.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// Persistence adapter.
protocol DatabaseService {

    // MARK: - Typealiases

    associatedtype DatabaseItem

    typealias Completion = ([DatabaseItem], Diff) -> Void

    // MARK: - Protocol requirements

    /// Save given object.
    /// - Parameter object: an object to save.
    func save(_ object: DatabaseItem) throws

    /// Delete given object.
    /// - Parameter object: an object to delete.
    func delete(_ object: DatabaseItem) throws

    /// Observe database changes in real-time.
    /// - Parameters:
    ///     - sorted: Sort option.
    ///     - predicate: Filtering predicate.
    ///     - completion: Completion handler.
    func observeChanges(sorted: SortOption?, predicate: NSPredicate?, completion: @escaping Completion)
}
