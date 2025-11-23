//
//  FavoriteServicesProtocol.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 23/11/25.
//

import Foundation

protocol FavoriteServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    var realm: RealmManagerProtocol { get }
    
    func makeGameDetailServices() -> GameDetailServicesProtocol
    func getLocaleGames() async throws -> [Game]
}
