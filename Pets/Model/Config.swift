//
//  Config.swift
//  Pets
//
//  Created by milan.mia on 7/28/20.
//  Copyright © 2020 milan. All rights reserved.
//

import Foundation

struct Config: Codable {
    var settings: Settings
}

struct Settings: Codable {
    let isChatEnabled: Bool
    let isCallEnabled: Bool
    let workHours: String
}
