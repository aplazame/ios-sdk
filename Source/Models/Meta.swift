import Foundation

public struct Meta {
    var record: APIRecordType {
        return [
            "platform": ["name": "ios"],
            "version": AplazameSDK.version
        ]
    }
}
