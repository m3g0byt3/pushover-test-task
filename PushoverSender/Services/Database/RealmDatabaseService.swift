//
//  RealmDatabaseService.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

// swiftlint:disable force_cast

import Foundation
import RealmSwift

final class RealmDatabaseService<T>: DatabaseService where T: Object, T: ModelObject, T.Model: Model {

    // MARK: - Private properties

    private var token: NotificationToken?
    private let configuration: Realm.Configuration

    // MARK: - Initialization

    init(configuration: Realm.Configuration = .defaultConfiguration) {
        self.configuration = configuration
    }

    deinit {
        token?.invalidate()
    }

    // MARK: - DatabaseService protocol conformance

    func save(_ object: T.Model) throws {
        let realm = try Realm(configuration: configuration)
        try realm.write {
            realm.add(object.modelObject as! T)
        }
    }

    func delete(_ object: T.Model) throws {
        let realm = try Realm(configuration: configuration)
        try realm.write {
            realm.delete(object.modelObject as! T)
        }
    }

    func observeChanges(sorted: SortOption?, predicate: NSPredicate?, completion: @escaping Completion) {
        let realm = try? Realm(configuration: configuration)

        var results = realm?.objects(T.self)

        if let sorted = sorted {
            results = results?.sorted(byKeyPath: sorted.keyPath, ascending: sorted.ascending)
        }

        if let predicate = predicate {
            results = results?.filter(predicate)
        }

        token = results?.observe() { changes in
            switch changes {

            case .initial(let some):
                let mapped = Array(some).map { $0.model }
                let diff = Diff.initial

                completion(mapped, diff)

            case .update(let some, let deletions, let insertions, let modifications):
                let mapped = Array(some).map { $0.model }
                let diff = Diff.updates(deletions: deletions.map { IndexPath(row: $0, section: 0) },
                                        insertions: insertions.map { IndexPath(row: $0, section: 0) },
                                        modifications: modifications.map { IndexPath(row: $0, section: 0) })

                completion(mapped, diff)

            case .error:
                // TODO: Handle an error
                break
            }
        }
    }
}
