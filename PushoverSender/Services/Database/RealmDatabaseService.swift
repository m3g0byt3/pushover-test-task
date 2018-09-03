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

    private var tokens = [NotificationToken?]()
    private let configuration: Realm.Configuration

    // MARK: - Initialization

    init(configuration: Realm.Configuration = .defaultConfiguration) {
        self.configuration = configuration
    }

    deinit {
        tokens.forEach { $0?.invalidate() }
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

        let token = results?.observe { changes in
            switch changes {

            case let.initial(objects):
                let models = Array(objects).map { $0.model }
                let diff = Diff.initial

                completion(models, diff)

            case let .update(objects, deletions, insertions, modifications):
                let models = Array(objects).map { $0.model }
                let diff = Diff.updates(deletions: deletions.map { IndexPath(row: $0, section: 0) },
                                        insertions: insertions.map { IndexPath(row: $0, section: 0) },
                                        modifications: modifications.map { IndexPath(row: $0, section: 0) })

                completion(models, diff)

            case .error:
                // TODO: Handle an error
                break
            }
        }

        tokens.append(token)
    }
}
