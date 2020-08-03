//
//  Pets.swift
//  Pets
//
//  Created by milan.mia on 7/28/20.
//  Copyright © 2020 milan. All rights reserved.
//

import Foundation

// MARK: - TopLevel
struct PetsList: Codable {
    var pets: [Pet]
}

// MARK: - Pet
struct Pet: Codable {
    var imageURL: String
    var title: String
    var contentURL: String
    var dateAdded: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case title
        case contentURL = "content_url"
        case dateAdded = "date_added"
    }
}
