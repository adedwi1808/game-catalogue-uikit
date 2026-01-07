//
//  DatabaseError.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 23/11/25.
//

import Foundation

enum DatabaseError: Error, LocalizedError {
    case writeFailed(message: String)
    case fetchFailed(message: String)
    case objectNotFound(message: String)
    case migrationError(message: String)
    case unknown
    case invalidInstance

    var errorDescription: String? {
        switch self {
        case .writeFailed(let message):
            return "Write Failed: \(message)"
        case .fetchFailed(let message):
            return "Fetch Failed: \(message)"
        case .objectNotFound(let message):
            return message
        case .migrationError(let message):
            return "Migration Error: \(message)"
        case .unknown:
            return "Unknown Database Error"
        case .invalidInstance:
            return "Failed To Make Realm Instance"
        }
    }
}
