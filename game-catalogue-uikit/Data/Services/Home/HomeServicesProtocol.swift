//
//  HomeServicesProtocol.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 23/11/25.
//

import Foundation

protocol HomeServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func getGames(endPoint: NetworkFactory) async throws -> PaginationResponseModel<GamesResponse>
    func makeGameDetailServices() -> GameDetailServicesProtocol
}
