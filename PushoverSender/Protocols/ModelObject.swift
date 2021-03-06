//
//  ModelObject.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// Adopted by persistence object subclass (e.g CoreData NSManagedObject / Realm Object)
protocol ModelObject {

    associatedtype Model

    /// Immutable representation (e.g plain Struct).
    var model: Model { get }
}
