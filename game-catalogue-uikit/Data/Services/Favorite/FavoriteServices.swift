//
//  FavoriteServices.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 23/11/25.
//

import Foundation

final class FavoriteServices: FavoriteServicesProtocol {
    var realm: any RealmManagerProtocol
    var networker: any NetworkerProtocol
    
    init(networker: any NetworkerProtocol, realm: any RealmManagerProtocol) {
        self.networker = networker
        self.realm = realm
    }
    
    func makeGameDetailServices() -> any GameDetailServicesProtocol {
        return GameDetailServices(networker: self.networker, realm: realm)
    }
    
    func getLocaleGames() async throws -> [Game] {
        let games = try await realm.fetch(type: GameEntity.self)
        return games.compactMap { $0.toDomain() }
    }
}
