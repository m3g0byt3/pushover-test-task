//
//  DatabaseService.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol DatabaseService {

    typealias Completion = ([DatabaseItem], Diff) -> Void

    associatedtype DatabaseItem

    func save(_ object: DatabaseItem) throws

    func delete(_ object: DatabaseItem) throws

    func observeChanges(sorted: SortOption?, predicate: NSPredicate?, completion: @escaping Completion)
}
