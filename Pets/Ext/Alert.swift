//
//  Alert.swift
//  Pets
//
//  Created by milan.mia on 7/28/20.
//  Copyright © 2020 milan. All rights reserved.
//

import UIKit

enum Alert {

    static func create(title: String? = nil, message: String,
                       okActionTitle: String = "OK",
                       okActionHandler: (() -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okActionTitle, style: .default, handler: { _ in
            okActionHandler?()
        })
        alertController.addAction(okAction)
        return alertController
    }
}
