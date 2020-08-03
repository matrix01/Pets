//
//  EndPointType.swift
//  Pets
//
//  Created by milan.mia on 7/28/20.
//  Copyright © 2020 milan. All rights reserved.
//

import Foundation

protocol EndPointType {

    var baseURL: URL { get }

    var path: String { get }

}
