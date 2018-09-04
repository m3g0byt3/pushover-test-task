//
//  Configurable.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// An object (e.g. an `UITableViewCell` instance) that can be configured with given model.
protocol Configurable {

    associatedtype Model

    /// Configure with given model
    /// - Parameter model: Model to configure from.
    @discardableResult
    func configure(with model: Model) -> Self
}
