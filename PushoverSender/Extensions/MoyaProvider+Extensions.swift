//
//  MoyaProvider+Extensions.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Moya
import Alamofire

/// Provides custom AlamofireManager
extension MoyaProvider {

    /// Class method that returns customized instance of Alamofire default manager.
    /// - Returns: Customized instance of Alamofire default manager.
    final class func customAlamofireManager() -> Manager {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = Constants.Network.timeout
        configuration.timeoutIntervalForResource = Constants.Network.timeout
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData

        let manager = Manager(configuration: configuration)
        manager.startRequestsImmediately = false

        return manager
    }
}
