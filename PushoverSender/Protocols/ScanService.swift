//
//  ScanService.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 02/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol ScanService {

    var delegate: ScanServiceDelegate? { get set }

    func prepare()

    func start()

    func stop()
}
