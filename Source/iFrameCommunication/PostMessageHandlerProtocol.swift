import Foundation


protocol PostMessageHandler {
    var callbackName: String { get }
    func handle(receivedMessage message: ScriptMessageType)
}

protocol ScriptMessageType: class {
    var bodyRecord: APIRecordType? { get }
    var name: String { get }
}
