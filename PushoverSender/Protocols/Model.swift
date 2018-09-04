//
//  Model.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// Adopted by immutable struct.
protocol Model {

    associatedtype ModelObject

    /// Persistence representation (e.g CoreData NSManagedObject / Realm Object).
    var modelObject: ModelObject { get }
}
