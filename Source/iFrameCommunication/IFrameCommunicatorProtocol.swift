//
//  IFrameCommunicatorProtocol.swift
//  Aplazame-sdk
//
//  Created by Andres Brun Moreno on 05/06/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

protocol IFrameCommunicator {
    func send(checkout: Checkout)
    func sendTokenConfirmation(with success: Bool)
}
