//
//  PostMessageHandler.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 05/06/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation


protocol PostMessageHandler {
    var callbackName: String { get }
    func handle(receivedMessage message: ScriptMessageType)
}

protocol ScriptMessageType: class {
    var bodyRecord: APIRecordType? { get }
    var name: String { get }
}
