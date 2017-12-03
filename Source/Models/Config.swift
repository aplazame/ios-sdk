//
//  Config.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 06/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

public struct Config {
    let accessToken: String
    let environment: Enviroment
    
    public init(accessToken: String, environment: Enviroment) {
        self.accessToken = accessToken
        self.environment = environment
    }    
}

extension Config {
    var record: APIRecordType {
        var record = APIRecordType()
        record["public_api_key"] = accessToken
        record["sandbox"] = environment.sandboxValue
        return record
    }
}
