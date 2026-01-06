//
//  RealmFactory.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 23/11/25.
//


import Foundation
import RealmSwift
internal import Realm

enum RealmFactory {
    case main
    case inMemory(identifier: String)
}

extension RealmFactory {
    // MARK: - File Name
    var fileName: String {
        switch self {
        case .main:
            return "game_catalogue.realm"
        case .inMemory(let identifier):
            return identifier
        }
    }
    
    // MARK: - Schema Version
    var schemaVersion: UInt64 {
        switch self {
        case .main:
            return 1
        case .inMemory:
            return 1
        }
    }
    
    // MARK: - Configuration
    var configuration: Realm.Configuration {
        switch self {
        case .main:
            let config = Realm.Configuration(
                fileURL: try? FileManager.default
                    .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    .appendingPathComponent(fileName),
                schemaVersion: 2,
                deleteRealmIfMigrationNeeded: true
            )
            return config
            
        case .inMemory(let identifier):
            return Realm.Configuration(inMemoryIdentifier: identifier)
        }
    }
}
