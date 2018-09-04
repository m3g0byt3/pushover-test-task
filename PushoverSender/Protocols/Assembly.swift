//
//  Assembly.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// Container with dependencies, provides data to the service locator.
protocol Assembly {

    /// Scene dependency.
    var scene: Presentable { get }

    /// `NetworkService` dependency.
    var networkService: NetworkService { get }

    /// `DatabaseService` dependency.
    var databaseService: AnyDatabaseService<HistoryItem> { get }
}
