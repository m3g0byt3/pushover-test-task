//
//  PushoverAPI.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

// TODO: Replace string literals with constants

import Foundation
import Moya

enum PushoverAPI: TargetType {

    case send(Message)
    case verify(Recipient)

    // MARK: - TargetType protocol conformance

    var baseURL: URL {
        var components = URLComponents()
        components.scheme = Constants.Network.baseURLScheme
        components.host = Constants.Network.baseURLHost

        guard let url = components.url else {
            fatalError("Unable to construct URL from components")
        }

        return url
    }

    var path: String {
        switch self {
        case .send: return "1/messages.json"
        case .verify: return "1/users/validate.json"
        }
    }

    var method: Moya.Method {
        return .post
    }

    var sampleData: Data {
        // TODO: Add stub data for testing
        return Data()
    }

    var task: Task {
        let parameters: [String: Any]
        switch self {
        case .send(let message):
            parameters = [
                "token": Constants.Network.apiToken,
                "user": message.recipient.key,
                "device": message.recipient.device ?? "",
                "title": message.title,
                "message": message.message
            ]

        case .verify(let recipient):
            parameters = [
                "token": Constants.Network.apiToken,
                "user": recipient.key,
                "device": recipient.device ?? ""
            ]
        }
        return .requestParameters(parameters: parameters, encoding: URLEncoding.httpBody)
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
}
