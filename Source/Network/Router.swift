//
//  Router.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 07/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://aplazame.com/")!

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


enum Router {
    case checkout
    
    var path: String {
        switch self {
        case .checkout: return "static/checkout/iframe.html"
        }
    }
    
    var url: URL {
        let url = baseURL.appendingPathComponent(path, isDirectory: false)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "timestamp", value: Date().ISO8601GMTString)]
        return components.url!
    }
}
