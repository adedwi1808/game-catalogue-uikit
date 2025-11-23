//
//  FavoriteViewModel.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//

import Foundation

protocol FavoriteViewModelProtocol: AnyObject {
    func onSuccess()
    func onFailed(message: String)
}

@MainActor
final class FavoriteViewModel {
    var games: [Game] = []
    
    weak var delegate: FavoriteViewModelProtocol? = nil
    
    private let services: FavoriteServicesProtocol
    
    init(services: FavoriteServicesProtocol) {
        self.services = services
    }
    
    func getLocaleGames() async {
        do {
            games = try await services.getLocaleGames()
            delegate?.onSuccess()
        } catch let error {
            print(error.localizedDescription)
            delegate?.onFailed(message: error.localizedDescription)
        }
    }
    
    func createDetailViewModel(for index: Int) -> GameDetailViewModel {
        let selectedGame = games[index]
        let detailServices = services.makeGameDetailServices()
        let detailViewModel = GameDetailViewModel(services: detailServices)
        detailViewModel.configureDataFromList(data: selectedGame)
        
        return detailViewModel
    }
}
