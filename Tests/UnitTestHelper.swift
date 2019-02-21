import Foundation
@testable import AplazameSDK

extension APZConfig {
    static func createBasicConfig() -> APZConfig {
        return APZConfig(accessToken: "token", environment: .sandbox)
    }
}
