//
//  APIManager.swift
//  Aplazame iOS SDK
//
//  Created by Andres Brun Moreno on 06/12/2017.
//  Copyright © 2017 Andres Brun Moreno. All rights reserved.
//

import Foundation

enum APIManagerResult {
    case success(Int, Data?)
    case error(Error?)
}

class APIManager {
    func request(route: Router,
                 token: String,
                 onFinish: @escaping (APIManagerResult) -> Void ) {
        let request = createRequest(with: route, and: token)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                guard let httpResponse = response as? HTTPURLResponse else {
                    onFinish(.error(error))
                    return
                }
                onFinish(.success(httpResponse.statusCode, data))
            })
        }
        task.resume()
    }
    
    fileprivate func createRequest(with route: Router, and token: String) -> URLRequest {
        var request = URLRequest(url: route.url)
        
        request.httpMethod = route.method
        
        request.setValue("application/vnd.aplazame.v1+json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        return request
    }
}
