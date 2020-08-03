//
//  Response.swift
//  Pets
//
//  Created by milan.mia on 7/28/20.
//  Copyright © 2020 milan. All rights reserved.
//

import Foundation
import UIKit

struct Response {
    fileprivate var data: Data
    init(data: Data) {
        self.data = data
    }
}

extension Response {
    public func decode<T: Codable>(_ type: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode(T.self, from: data)
            return response
        } catch let error {
            DispatchQueue.main.async {
                let alert = Alert.create(message: error.localizedDescription)
                UIApplication.getTopViewController()?.present(alert, animated: true, completion: nil)
            }
            return nil
        }
    }
}
