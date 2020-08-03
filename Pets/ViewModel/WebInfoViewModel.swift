//
//  WebInfoViewModel.swift
//  Pets
//
//  Created by milan.mia on 7/28/20.
//  Copyright © 2020 milan. All rights reserved.
//

import Foundation

class WebInfoViewModel {

    private let pet: Pet

    init(pet: Pet) {
        self.pet = pet
    }

    var name: String {
        return pet.title
    }

    var imageUrl: String {
        return pet.imageURL
    }

    var descUrl: String {
        return pet.contentURL
    }
}
