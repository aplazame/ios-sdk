import Foundation

public enum Enviroment {
    case sandbox
    case production
    
    init(sandbox: Bool) {
        if sandbox {
            self = .sandbox
        } else {
            self = .production
        }
    }
    
    var sandboxValue: Bool {
        switch self {
        case .sandbox: return true
        case .production: return false
        }
    }
}

typealias RequestParameters = [String: String]

enum Router {
    case checkout(APZConfig)
    case checkAvailability(APZConfig, Double, String)
    
    var baseURL: URL {
        switch self {
        case .checkout(let config):
            return config.checkoutBaseUri
        case .checkAvailability(let config, _, _):
            return config.apiBaseUri
        }
    }
    
    var path: String {
        switch self {
        case .checkout: return "/"
        case .checkAvailability: return "/checkout/button"
        }
    }
    
    var url: URL {
        let url = baseURL.appendingPathComponent(path, isDirectory: false)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        let queryItems = params.map { param -> URLQueryItem in
            let value = param.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            return URLQueryItem(name: param.key, value: value)
        }
        components.queryItems = queryItems + [URLQueryItem(name: "timestamp", value: Date().ISO8601GMTString)]
        return components.url!
    }
    
    var params: RequestParameters {
        switch self {
        case .checkout(let config):
            let os = ProcessInfo().operatingSystemVersion
            let module_version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String

            return [
                "public-key": config.accessToken,
                "sandbox": "\(config.environment.sandboxValue)",
                "post-message": "\(true)",
                "platform-name": "ios",
                "platform-version": String(os.majorVersion) + "." + String(os.minorVersion) + "." + String(os.patchVersion),
                "module-name": "aplazame",
                "module-version": module_version
            ]
        case .checkAvailability(_, let amount, let currency):
            let apzAmount = Int(amount * 100)
            return [
                "amount": "\(apzAmount)",
                "currency": currency,
            ]
        }
    }
    
    var method: String {
        switch self {
        case .checkAvailability, .checkout:
            return "GET"
        }
    }
}
