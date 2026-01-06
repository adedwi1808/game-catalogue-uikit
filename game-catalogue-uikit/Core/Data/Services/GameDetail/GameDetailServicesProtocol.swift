//
//  GameDetailServicesProtocol.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 23/11/25.
//

import Foundation

protocol GameDetailServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    var realm: RealmManagerProtocol { get }
    
    func getGameDetail(endPoint: NetworkFactory) async throws -> GamesResponse
    
    func saveToFavorite(game: Game) async throws
    func removeFromFavorite(game: Game) async throws
    func checkIsFavorite(id: Int) async -> Bool
}
