//
//  HomeInteractorTests.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 07/01/26.
//

import Combine
import XCTest

@testable import game_catalogue_uikit

final class HomeInteractorTests: XCTestCase {

    var sut: HomeInteractor!
    var mockRepo: MockGameRepository!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepo = MockGameRepository()
        sut = HomeInteractor(repository: mockRepo)
        cancellables = []
    }

    override func tearDown() {
        sut = nil
        mockRepo = nil
        cancellables = nil
        super.tearDown()
    }

    func test_getGames_success_shouldReturnGames() {
        // Given
        let expectedGames = [MockData.sampleGame]
        mockRepo.gamesResult = .success(expectedGames)
        let expectation = XCTestExpectation(description: "Fetch games success")

        // When
        sut.getGames(endPoint: .getGames(search: "", page: 1, pageSize: 10))
            .sink(
                receiveCompletion: { completion in
                    if case .failure = completion {
                        XCTFail("Seharusnya tidak gagal")
                    }
                },
                receiveValue: { games in
                    // Then (Verifikasi)
                    XCTAssertEqual(games.count, 1)
                    XCTAssertEqual(games.first?.name, "Test Game")
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func test_getGames_failure_shouldReturnError() {
        // Given
        let expectedError = URLError(.notConnectedToInternet)
        mockRepo.gamesResult = .failure(expectedError)
        let expectation = XCTestExpectation(description: "Fetch games failed")

        // When
        sut.getGames(endPoint: .getGames(search: "", page: 1, pageSize: 10))
            .sink(
                receiveCompletion: { completion in
                    // Then
                    if case .failure(let error) = completion {
                        XCTAssertEqual(error as? URLError, expectedError)
                        expectation.fulfill()
                    }
                },
                receiveValue: { _ in
                    XCTFail("Seharusnya tidak mengembalikan data")
                }
            )
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
