//
//  Configurator.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// Simple service locator, inspired by Moya.
final class Configurator<A: Assembly> {

    // MARK: - Typealiases

    typealias SceneClosure = (A) -> Presentable

    // MARK: - Private properties

    /// Scene mapping closure.
    private let sceneClosure: SceneClosure

    // MARK: - Initialization

    /// Init with given Scene mapping closure.
    /// - Parameter sceneClosure: Scene mapping closure.
    /// - Returns: New service locator with given mapping closure.
    init(sceneClosure: @escaping SceneClosure = Configurator.sceneMapping) {
        self.sceneClosure = sceneClosure
    }
}

// MARK: - Public API

extension Configurator {

    /// Get requred scene.
    /// - Parameter type: The type of scene.
    /// - Returns: Scene (an instance that conforms to `Presentable` protocol).
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
