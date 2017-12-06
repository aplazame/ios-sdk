//
//  NSURLRequestExtension.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 07/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

extension URLRequest {
    static func createPOST(_ url: URL, params: APIRecordType) -> URLRequest {
        let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        return request as URLRequest
    }
}
