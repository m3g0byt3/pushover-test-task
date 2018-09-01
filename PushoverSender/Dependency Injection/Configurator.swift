//
//  Configurator.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// Simple dependency injector, inspired by Moya.
final class Configurator<A: Assembly> {

    // MARK: - Typealiases

    typealias SceneClosure = (A) -> Presentable

    // MARK: - Private properties

    private let sceneClosure: SceneClosure

    // MARK: - Initialization

    init(sceneClosure: @escaping SceneClosure = Configurator.sceneMapping) {
        self.sceneClosure = sceneClosure
    }
}

// MARK: - Public API

extension Configurator {

    func getScene(_ type: A) -> Presentable {
        return sceneClosure(type)
    }
}

// MARK: - Private API

private extension Configurator {

    static func sceneMapping(assembly: A) -> Presentable {
        return assembly.scene
    }
}
