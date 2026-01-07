//
//  FavoriteInteractor.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 07/01/26.
//

import Combine
import Foundation

protocol FavoriteUseCase {
    func getLocaleGames() -> AnyPublisher<[Game], Error>
}

final class FavoriteInteractor: FavoriteUseCase {

    private let repository: GameRepositoryProtocol

    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }

    func getLocaleGames() -> AnyPublisher<[Game], Error> {
        repository.getLocaleGames()
    }
}
