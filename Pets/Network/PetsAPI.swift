//
//  PetsAPI.swift
//  Pets
//
//  Created by milan.mia on 7/28/20.
//  Copyright © 2020 milan. All rights reserved.
//

import Foundation

enum PetsAPI {
    case pets
    case config
}

extension PetsAPI: EndPointType {
    var baseURL: URL {
        return URL(string: "https://i-savvy.com/pets")!
    }

    var path: String {
        switch self {
        case .pets:
            return "/pets.json"
        case .config:
            return "/config.json"
        }
    }
}

