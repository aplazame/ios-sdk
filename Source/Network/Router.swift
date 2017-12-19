//
//  Router.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 07/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

public enum Enviroment {
    case sandbox
    case production
    
    init(sandbox: Bool) {
        if sandbox {
            self = .sandbox
        } else {
            self = .production
        }
    }
    
    var sandboxValue: Bool {
        switch self {
        case .sandbox: return true
        case .production: return false
        }
    }
}

typealias RequestParameters = [String: String]

enum Router {
    case checkout(APZConfig)
    case checkAvailability(APZOrder)
    
    var baseURL: URL {
        switch self {
        case .checkout: return URL(string: "https://checkout.aplazame.com")!
        case .checkAvailability: return URL(string: "https://api.aplazame.com")!
        }
    }
    
    var path: String {
        switch self {
        case .checkout: return "/"
        case .checkAvailability: return "/checkout/button"
        }
    }
    
    var url: URL {
        let url = baseURL.appendingPathComponent(path, isDirectory: false)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        let queryItems = params.map { param -> URLQueryItem in
            let value = param.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            return URLQueryItem(name: param.key, value: value)
        }
        components.queryItems = queryItems + [URLQueryItem(name: "timestamp", value: Date().ISO8601GMTString)]
        return components.url!
    }
    
    var params: RequestParameters {
        switch self {
        case .checkout(let config):
            return [
                "public-key": config.accessToken,
                "sandbox": "\(config.environment.sandboxValue)",
                "post-message": "\(true)"
            ]
        case .checkAvailability(let order):
            return [
                "amount": "\(order.totalAmount)",
                "currency": order.locale.currencyCode ?? ""
            ]
        }
    }
    
    var method: String {
        switch self {
        case .checkAvailability, .checkout: return "GET"
        }
    }
}
