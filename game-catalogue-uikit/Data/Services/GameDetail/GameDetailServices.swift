//
//  GameDetailServices.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 23/11/25.
//

import Foundation

final class GameDetailServices: GameDetailServicesProtocol {
    var networker: any NetworkerProtocol
    
    init(networker: any NetworkerProtocol) {
        self.networker = networker
    }
    
    func getGameDetail(endPoint: NetworkFactory) async throws -> GamesResponse {
        try await networker.taskAsync(type: GamesResponse.self, endPoint: endPoint, isMultipart: false)
    }
}
