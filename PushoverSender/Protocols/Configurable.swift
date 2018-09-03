//
//  Configurable.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol Configurable {

    associatedtype Model

    @discardableResult
    func configure(with model: Model) -> Self
}
