//
//  Ext.swift
//  Pets
//
//  Created by milan.mia on 7/28/20.
//  Copyright © 2020 milan. All rights reserved.
//

import UIKit
import Foundation

extension Bundle {

    //Just using for test purpose
    func jsonData(fileName: String) -> Data {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
              } catch (let error){
                print(error.localizedDescription)
                   return Data()
              }
        }
        return Data()
    }
}

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}

extension DateFormatter {

    static func with(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = format
        return formatter
    }
    
    static var clock: DateFormatter {
        with(format: "HH:mm")
    }
}

extension Date {
    var ISOTime: Date? {
        DateFormatter.clock.string(from: self).clock
    }
    
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

    static var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    }
}

extension String {
    var clock: Date? {
        DateFormatter.clock.date(from: self)
    }
}

// MARK: UIApplication extensions
extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

extension UIStackView {
    func removeAllViews() {
        for view in self.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
}
