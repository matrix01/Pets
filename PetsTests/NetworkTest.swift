//
//  NetworkTest.swift
//  PetsTests
//
//  Created by milan.mia on 7/29/20.
//  Copyright © 2020 milan. All rights reserved.
//

import XCTest
@testable import Pets

class APIStabTests: XCTestCase {
    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Successful API call with raw URL
    func network_data_successfull() throws {
        let expectation = XCTestExpectation(description: "Waiting for the API call to return")
        let networkManager = Networking()
        networkManager.requestNetworkTask(endpoint: .config, type: Config.self) { (result) in
            switch result {
            case .success(let config):
                print(config)
                XCTAssertEqual(config.settings.isCallEnabled, true)
                XCTAssertEqual(config.settings.isChatEnabled, true)
                XCTAssertEqual(config.settings.workHours, "M-F 23:00 - 23:45")
            case .failure:
                break
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }

    // MARK: - Successful API call with local json data
    func local_json_data_successfull() throws {
        let expectation = XCTestExpectation(description: "Waiting for the API call to return")
        let networkManager = NetworkingStab()
        networkManager.requestNetworkTask(endpoint: .config, type: Config.self) { (result) in
            switch result {
            case .success(let config):
                print(config)
                XCTAssertEqual(config.settings.isCallEnabled, true)
                XCTAssertEqual(config.settings.isChatEnabled, true)
                XCTAssertEqual(config.settings.workHours, "M-F 23:00 - 23:45")
            case .failure:
                break
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
