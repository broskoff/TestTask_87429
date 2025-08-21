//
//  UserSettings.swift
//  TestTask_87429
//
//  Created by Tanya G. on 21.08.2025.
//

import Foundation

class UserSettings {
    
    private enum SettingsKeys: String {
        case userName
    }
    
    static var userName: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.userName.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userName.rawValue
            if let name = newValue {
                defaults.set(name, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}
