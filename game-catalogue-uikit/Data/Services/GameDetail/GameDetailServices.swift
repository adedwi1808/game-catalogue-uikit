//
//  GameDetailServices.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 23/11/25.
//

import Foundation

final class GameDetailServices: GameDetailServicesProtocol {
    var realm: any RealmManagerProtocol
    var networker: any NetworkerProtocol
    
    init(networker: any NetworkerProtocol, realm: any RealmManagerProtocol) {
        self.networker = networker
        self.realm = realm
    }
    
    func getGameDetail(endPoint: NetworkFactory) async throws -> GamesResponse {
        try await networker.taskAsync(type: GamesResponse.self, endPoint: endPoint, isMultipart: false)
    }
    
    func saveToFavorite(game: Game) async throws {
        let gameEntity = game.toEntity()
        
        try await realm.save(object: gameEntity)
    }
    
    func removeFromFavorite(game: Game) async throws {
        let gameEntity = game.toEntity()
        try await realm.delete(object: gameEntity)
    }
    
    func checkIsFavorite(id: Int) async -> Bool {
        do {
            let results = try await realm.fetch(type: GameEntity.self, filter: "id == \(id)")
            return !results.isEmpty
        } catch {
            return false
        }
    }
}
