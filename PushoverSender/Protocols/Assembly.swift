//
//  Assembly.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol Assembly {

    var scene: Presentable { get }

    var networkService: NetworkService { get }

    var databaseService: AnyDatabaseService<HistoryItem> { get }
}
