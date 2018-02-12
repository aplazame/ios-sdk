import Foundation

public struct APZConfig {
    let accessToken: String
    let environment: Enviroment
    
    public init(accessToken: String, environment: Enviroment) {
        self.accessToken = accessToken
        self.environment = environment
    }    
}

extension APZConfig {
    var record: APIRecordType {
        var record = APIRecordType()
        record["public_api_key"] = accessToken
        record["debug"] = environment.sandboxValue
        return record
    }
}
