import Foundation

public struct APZConfig {
    let accessToken: String
    let environment: Enviroment
    let apiBaseUri = URL(string: "https://api.aplazame.com")!
    let checkoutBaseUri = URL(string: "https://checkout.aplazame.com")!
    
    public init(accessToken: String, environment: Enviroment) {
        self.accessToken = accessToken
        self.environment = environment
    }
}
