//
//  HomeServices.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 23/11/25.
//

import Foundation

final class HomeServices: HomeServicesProtocol {
    var realm: any RealmManagerProtocol
    var networker: any NetworkerProtocol
    
    init(networker: any NetworkerProtocol, realm: any RealmManagerProtocol) {
        self.networker = networker
        self.realm = realm
    }
    
    func getGames(endPoint: NetworkFactory) async throws -> PaginationResponseModel<GamesResponse> {
        try await networker.taskAsync(type: PaginationResponseModel<GamesResponse>.self, endPoint: endPoint, isMultipart: false)
    }
    
    func makeGameDetailServices() -> GameDetailServicesProtocol {
        return GameDetailServices(networker: self.networker, realm: realm)
    }
}
