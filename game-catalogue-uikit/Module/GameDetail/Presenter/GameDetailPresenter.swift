//
//  GameDetailPresenter.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 07/01/26.
//

import Combine
import Foundation

protocol GameDetailViewProtocol: AnyObject {
    func showLoading(_ isLoading: Bool)
    func render(game: Game?, isFavorited: Bool)
    func showError(message: String)
}

@MainActor
final class GameDetailPresenter {

    weak var view: GameDetailViewProtocol?

    private let useCase: GameDetailUseCase
    private var cancellables = Set<AnyCancellable>()

    private(set) var game: Game?
    private(set) var isFavorited: Bool = false

    init(useCase: GameDetailUseCase) {
        self.useCase = useCase
    }

    func setInitialGame(_ game: Game) {
        self.game = game
        checkIsFavorite()
    }

    func fetchGameDetail() {
        guard let id = game?.id else { return }

        view?.showLoading(true)

        useCase.getGameDetail(endPoint: .getGameDetail(id: id))
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.view?.showLoading(false)
                    if case .failure(let error) = completion {
                        self?.view?.showError(
                            message: error.localizedDescription
                        )
                    }
                },
                receiveValue: { [weak self] game in
                    self?.game = game
                    self?.view?.render(
                        game: game,
                        isFavorited: self?.isFavorited ?? false
                    )
                }
            )
            .store(in: &cancellables)
    }

    private func checkIsFavorite() {
        guard let id = game?.id else { return }

        useCase.checkIsFavorite(id: id)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] isFav in
                    self?.isFavorited = isFav
                    self?.view?.render(
                        game: self?.game,
                        isFavorited: isFav
                    )
                }
            )
            .store(in: &cancellables)
    }

    func toggleFavorite() {
        guard let game else { return }

        let action =
            isFavorited
            ? useCase.removeFromFavorite(game: game)
            : useCase.saveToFavorite(game: game)

        view?.showLoading(true)

        action
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.view?.showLoading(false)
                    if case .failure(let error) = completion {
                        self?.view?.showError(
                            message: error.localizedDescription
                        )
                    }
                },
                receiveValue: { [weak self] in
                    guard let self else { return }
                    self.isFavorited.toggle()
                    self.view?.render(
                        game: self.game,
                        isFavorited: self.isFavorited
                    )
                }
            )
            .store(in: &cancellables)
    }
}
