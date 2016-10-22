//
//  ImageViewExtension.swift
//  Aplazame-ios-sdk-demo
//
//  Created by Andres Brun Moreno on 18/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(ImageURL url: URL) {
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }).resume()
    }
}
