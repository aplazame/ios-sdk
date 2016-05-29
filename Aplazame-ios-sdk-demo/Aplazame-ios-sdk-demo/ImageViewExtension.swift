//
//  ImageViewExtension.swift
//  Aplazame-ios-sdk-demo
//
//  Created by Andres Brun Moreno on 18/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImageURL(url: NSURL) {
        let request = NSURLRequest(URL: url)
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            guard let data = data else { return }
            dispatch_async(dispatch_get_main_queue()) {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}