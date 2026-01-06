//
//  UserDefaults+Extension.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 29/11/25.
//

import Foundation

extension UserDefaults {
    func getDataFromLocal<T: Codable>(_ type: T.Type, with key: Key, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key.rawValue) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }
    
    func setDataToLocal<T: Codable>(_ object: T, with key: Key, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        self.set(data, forKey: key.rawValue)
    }
    
    func resetLocale() {
        for key in Key.allCases {
            self.removeObject(forKey: key.rawValue)
        }
    }
    
    class var name: String? {
        get {
            return UserDefaults.standard.getDataFromLocal(String.self, with: .name)
        } set {
            UserDefaults.standard.setDataToLocal(newValue, with: .name)
        }
    }
    
    class var email: String? {
        get {
            return UserDefaults.standard.getDataFromLocal(String.self, with: .email)
        } set {
            UserDefaults.standard.setDataToLocal(newValue, with: .email)
        }
    }
}

extension UserDefaults {
    enum Key: String, CaseIterable {
        case name
        case email
    }
}
