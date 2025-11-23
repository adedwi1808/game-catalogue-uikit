//
//  HomeServices.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 23/11/25.
//

import Foundation

final class HomeServices: HomeServicesProtocol {
    var networker: any NetworkerProtocol
    
    init(networker: any NetworkerProtocol) {
        self.networker = networker
    }
    
    func getGames(endPoint: NetworkFactory) async throws -> PaginationResponseModel<GamesResponse> {
        try await networker.taskAsync(type: PaginationResponseModel<GamesResponse>.self, endPoint: endPoint, isMultipart: false)
    }
    
    func makeGameDetailServices() -> GameDetailServicesProtocol {
        return GameDetailServices(networker: self.networker)
    }
}
