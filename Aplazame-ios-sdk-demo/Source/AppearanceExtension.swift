import UIKit

extension UINavigationItem {
    func applyLogo() {
        titleView = UIImageView(image: UIImage(named: "logotipo-white"))
    }
}

extension UINavigationController {
    func applyStyle() {
        navigationBar.barTintColor = .aBlueColor()
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false        
    }
}

extension UIColor {
    static func aBlueColor() -> UIColor {
        return UIColor(red: 38.0 / 255.0, green: 123.0 / 255.0, blue: 189.0 / 255.0, alpha: 1)
    }
}
