//
//  HomeInteractor.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 06/01/26.
//

import Combine
import Foundation

protocol HomeUseCase {
    func getGames(endPoint: NetworkFactory) -> AnyPublisher<[Game], Error>
}

final class HomeInteractor: HomeUseCase {

    private let repository: GameRepositoryProtocol

    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }

    func getGames(endPoint: NetworkFactory) -> AnyPublisher<[Game], any Error> {
        repository.getGames(endPoint: endPoint)
    }
}
