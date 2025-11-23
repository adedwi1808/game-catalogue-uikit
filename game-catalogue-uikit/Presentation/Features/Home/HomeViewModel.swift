//
//  HomeViewModel.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func onSuccess()
    func onFailed(message: String)
    func onLoading(_ isLoading: Bool)
}

@MainActor
final class HomeViewModel {
    var query: String = ""
    var page: Int = 1
    private var pageSize: Int = 10
    
    var games: [Game] = []
    var isLoading: Bool = false
    var hasMoreData: Bool = true
    
    weak var delegate: HomeViewModelProtocol? = nil
    private let services: HomeServicesProtocol
    
    init(services: HomeServicesProtocol) {
        self.services = services
    }
    
    func loadNextPage() {
        guard !isLoading, hasMoreData else { return }
        page += 1
        Task {
            await getGames()
        }
    }
    
    func searchGames(query: String) {
        self.query = query
        self.page = 1
        self.games = []
        self.hasMoreData = true
        Task {
            await getGames()
        }
    }
    
    func getGames() async {
        isLoading = true
        if page > 1 { delegate?.onLoading(true) }
        
        do {
            let response = try await services.getGames(endPoint: .getGames(search: query, page: page, pageSize: pageSize))
            let newGames: [Game] = response.results?.toDomain() ?? []
            
            if newGames.count < pageSize {
                hasMoreData = false
            }
            
            games = page > 1 ? games + newGames : newGames
            delegate?.onSuccess()
        } catch let error {
            if error is NetworkError {
                print(error.localizedDescription)
                delegate?.onFailed(message: error.localizedDescription)
            }
        }
        
        isLoading = false
        delegate?.onLoading(false)
    }
    
    func createDetailViewModel(for index: Int) -> GameDetailViewModel {
        let selectedGame = games[index]
        let detailServices = services.makeGameDetailServices()
        let detailViewModel = GameDetailViewModel(services: detailServices)
        detailViewModel.configureDataFromList(data: selectedGame)
        
        return detailViewModel
    }
}
