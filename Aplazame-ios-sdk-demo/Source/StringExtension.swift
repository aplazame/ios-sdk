import Foundation

extension String {
    static var randomID: String {
        
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let lettersLength = UInt32(letters.count)
        
        let randomCharacters = (0..<4).map { i -> String in
            let offset = Int(arc4random_uniform(lettersLength))
            let c = letters[letters.index(letters.startIndex, offsetBy: offset)]
            return String(c)
        }
        
        return randomCharacters.joined(separator: "")
    }
}
