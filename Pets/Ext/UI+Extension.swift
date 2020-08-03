//
//  UI+Extension.swift
//  Pets
//
//  Created by milan.mia on 7/28/20.
//  Copyright © 2020 milan. All rights reserved.
//

import UIKit

extension UIStoryboard {
    class func stwithName(name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
}

extension UIView {
    func setBorder(with color: UIColor = .clear, borderWidth: CGFloat = 0) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
    }
}

extension UIColor {
    static let petGreen = UIColor(red: 63/255, green: 210/255, blue: 95/255, alpha: 1)
    static let petBlue = UIColor(red: 18/255, green: 127/255, blue: 251/255, alpha: 1)
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIImageView {

    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?) {

        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }

        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

                //print("RESPONSE FROM API: \(response)")
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    DispatchQueue.main.async { [weak self] in
                        self?.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self?.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
