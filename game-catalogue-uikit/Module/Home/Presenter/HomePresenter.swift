//
//  HomePresenter.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 06/01/26.
//

import Foundation
import Combine

protocol HomeViewProtocol: AnyObject {
    func onSuccess()
    func onFailed(message: String)
    func onLoading(_ isLoading: Bool)
}

@MainActor
final class HomePresenter {

    weak var delegate: HomeViewProtocol?

    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase

    private let querySubject = CurrentValueSubject<String, Never>("")
    private var cancellables = Set<AnyCancellable>()

    private(set) var games: [Game] = []

    private var page = 1
    private let pageSize = 10
    private var isLoading = false
    private var hasMoreData = true

    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
        bind()
    }

    private func bind() {
        querySubject
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .handleEvents(receiveRequest:  { [weak self] _ in
                self?.reset()
                self?.delegate?.onLoading(true)
            })
            .flatMap { [weak self] query -> AnyPublisher<[Game], Error> in
                guard let self else { return Empty().eraseToAnyPublisher() }

                return self.homeUseCase.getGames(
                    endPoint: .getGames(
                        search: query,
                        page: self.page,
                        pageSize: self.pageSize
                    )
                )
            }
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.delegate?.onLoading(false)
                    if case let .failure(error) = completion {
                        self?.delegate?.onFailed(message: error.localizedDescription)
                    }
                },
                receiveValue: { [weak self] games in
                    guard let self else { return }
                    self.games = games
                    self.hasMoreData = games.count == self.pageSize
                    self.delegate?.onSuccess()
                }
            )
            .store(in: &cancellables)
    }

    private func reset() {
        page = 1
        games.removeAll()
        hasMoreData = true
    }

    func loadInitial() {
        querySubject.send("")
    }

    func refresh() {
        querySubject.send(querySubject.value)
    }

    func searchQueryChanged(_ query: String) {
        querySubject.send(query)
    }

    func loadNextPage() {
        guard !isLoading, hasMoreData else { return }

        isLoading = true
        page += 1

        homeUseCase.getGames(
            endPoint: .getGames(
                search: querySubject.value,
                page: page,
                pageSize: pageSize
            )
        )
        .sink(
            receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            },
            receiveValue: { [weak self] newGames in
                guard let self else { return }
                self.games.append(contentsOf: newGames)
                self.hasMoreData = newGames.count == self.pageSize
                self.delegate?.onSuccess()
            }
        )
        .store(in: &cancellables)
    }

    func navigateToDetail(index: Int) {
        router.makeDetailPage(for: games[index])
    }
}
