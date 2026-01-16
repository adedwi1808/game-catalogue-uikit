//
//  MockHomeUseCase.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 07/01/26.
//

import Combine
import Foundation

@testable import game_catalogue_uikit
import Core

class MockHomeUseCase: HomeUseCase {
    var result: Result<[Game], Error> = .success([])

    func getGames(endPoint: NetworkFactory) -> AnyPublisher<[Game], Error> {
        return result.publisher.eraseToAnyPublisher()
    }
}
