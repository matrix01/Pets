//
//  PetsViewControllerModel.swift
//  Pets
//
//  Created by milan.mia on 7/28/20.
//  Copyright © 2020 milan. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

enum BtnType: Int {
    case call = 100
    case chat = 101
}

class PetsViewControllerModel {
    private let networking = Networking()

    private var petList: PetsList?
    private var config: Settings?

    func getConfig(completion: (() -> Void)?) {
        networking.requestNetworkTask(endpoint: .config, type: Config.self) {[weak self] response in
            switch response {
            case.success(let config):
                self?.config = config.settings
            case .failure(let error):
                self?.showAlert(with: error.localizedDescription)
            }
            completion?()
        }
    }

    func getPets(completion: (() -> Void)?) {
        networking.requestNetworkTask(endpoint: .pets, type: PetsList.self) {[weak self] response in
            switch response {
            case.success(let petList):
                self?.petList = petList
            case .failure(let error):
                self?.showAlert(with: error.localizedDescription)
            }
            completion?()
        }
    }

    func cellViewModel(index: Int) -> PetTableViewCellModel? {
        guard let pets = petList?.pets else { return nil }
        let petTableViewCellModel = PetTableViewCellModel(pet: pets[index])
        return petTableViewCellModel
    }

    func webViewModel(index: Int) -> WebInfoViewModel? {
        guard let pets = petList?.pets else { return nil }
        let webInfoModel = WebInfoViewModel(pet: pets[index])
        return webInfoModel
    }

    var count: Int {
        return petList?.pets.count ?? 0
    }

    var officeHours: String {
        return "Office Hours: \(config?.workHours ?? "")"
    }

    private var startTime: Date {
        let components = officeHours.components(separatedBy: " ")
        let startingHour = components[3]
        return startingHour.clock ?? Date.dayBefore
    }

    private var endTime: Date {
        let components = officeHours.components(separatedBy: " ")
        let endingTime = components.last
        return endingTime?.clock ?? "00:00".clock!
    }

    // considering default is chat shown
    var isChatEnabled: Bool {
        return config?.isChatEnabled ?? true
    }

    // considering default is call shown
    var isCallEnabled: Bool {
        return config?.isCallEnabled ?? true
    }

    var showTopView: Bool {
        return isCallEnabled || isChatEnabled
    }

    private var onTimeMessage: String {
        return "Thank you for getting in touch with us. We’ll get back to you as soon as possible."
    }

    private var outTimeMessage: String {
        return "Work hours has ended. Please contact us again on the next work day."
    }

    func messageToShow() -> String {
        let now = Date().ISOTime ?? Date()
        let nowLocalTime = now.toLocalTime()
        let startLocal = startTime.toLocalTime()
        let endLocal = endTime.toLocalTime()

        print(nowLocalTime, startLocal, endLocal)

        if nowLocalTime > startLocal && nowLocalTime < endLocal {
            return onTimeMessage
        }else {
            return outTimeMessage
        }
    }

    private func showAlert(with msg: String) {
        DispatchQueue.main.async {
            let alert = Alert.create(message: msg)
            UIApplication.getTopViewController()?.present(alert, animated: true, completion: nil)
        }
    }
}


class PetTableViewCellModel {

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
}
