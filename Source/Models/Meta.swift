//
//  Meta.swift
//  Aplazame-sdk
//
//  Created by Andres Brun on 25/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

struct Meta {
    var record: APIRecordType {
        return [
            "platform": ["name": "ios"],
            "version": AplazameSDK.version
        ]
    }
}
