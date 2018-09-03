//
//  Diff.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

enum Diff {

    case initial
    case updates(deletions: [IndexPath], insertions: [IndexPath], modifications: [IndexPath])
}
