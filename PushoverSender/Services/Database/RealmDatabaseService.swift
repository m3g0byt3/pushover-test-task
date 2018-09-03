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

    private let configuration: Realm.Configuration

    // MARK: - Initialization

    init(configuration: Realm.Configuration = .defaultConfiguration) {
        self.configuration = configuration
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
}
