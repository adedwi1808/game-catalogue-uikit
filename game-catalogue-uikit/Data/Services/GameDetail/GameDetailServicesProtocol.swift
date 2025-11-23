//
//  GameDetailServicesProtocol.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 23/11/25.
//

import Foundation

protocol GameDetailServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func getGameDetail(endPoint: NetworkFactory) async throws -> GamesResponse
}
