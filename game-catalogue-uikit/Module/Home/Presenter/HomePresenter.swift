//
//  HomePresenter.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 06/01/26.
//

import Foundation
import Combine

@MainActor
final class HomePresenter: ObservableObject {
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase

    @Published var query: String = ""
    @Published var page: Int = 1
    private var pageSize: Int = 10

    @Published var games: [Game] = []
    @Published var isLoading: Bool = false
    @Published var hasMoreData: Bool = true
    @Published var errorMessage: PassthroughSubject<String, Never> = PassthroughSubject()

    private var cancellables: Set<AnyCancellable> = []

    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }

    func loadNextPage() {
        guard !isLoading, hasMoreData else { return }
        page += 1
        getGames()
    }

    func searchGames(query: String) {
        self.query = query
        self.page = 1
        self.games = []
        self.hasMoreData = true
        getGames()
    }

    func getGames() {
        isLoading = true

        homeUseCase.getGames(
            endPoint: .getGames(
                search: query,
                page: page,
                pageSize: pageSize
            )
        )
        .receive(on: RunLoop.main)
        .sink { result in
            switch result {
            case .finished:
                self.isLoading = false
            case .failure(let error):
                self.errorMessage.send(error.localizedDescription)
            }
        } receiveValue: { [weak self] newGames in
            guard let self else { return }
            if newGames.count < pageSize {
                hasMoreData = false
            }

            games = page > 1 ? games + newGames : newGames
        }.store(in: &cancellables)
    }
}
