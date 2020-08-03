//
//  Error.swift
//  Pets
//
//  Created by milan.mia on 7/28/20.
//  Copyright © 2020 milan. All rights reserved.
//

//Error just to demostrate the error class. Not all cases are implemented

import Foundation

/// Error
internal enum PetsError: Error {
    case connectionDisconnected
    case connectionTimedOut
    case connectionCanceled
    case badServerResponse
    case emptyData
    case emptyResponse
    case serverError
    case systemError(code: SystemErrorCode)
    case unknown

    var localizedDescription:(title: String, message: String) {
        switch self {
        case .connectionDisconnected:
            return ("", "Connection disconnected!")
        case .connectionTimedOut:
            return ("", "Connection Timedout!")
        case .connectionCanceled:
            return ("", "Connection Cancelled!")
        case .unknown:
            return ("", "Unknowned Error")
        case .systemError(code: let code):
            return ("", code.localizedDescription)
        case .badServerResponse:
            return ("", "bad server response")
        case .emptyData:
            return ("", "Empty data from server")
        case .emptyResponse:
            return ("", "Empty response from server")
        case .serverError:
            return ("", "Server error!")
        }
    }

    static func errorWithSystemError(_ error: PetsError) -> Result<Data, PetsError>? {
        switch error {
        case .systemError(let code):
            switch code {
            default:
                return .failure(.unknown)
            }
        default:
            return .failure(error)
        }
    }
}

internal enum SystemErrorCode: Int {
    case unknown

    init(_ code: Int) {
        self = SystemErrorCode(rawValue: code) ?? .unknown
    }

    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Unknown System error!"
        }
    }
}

