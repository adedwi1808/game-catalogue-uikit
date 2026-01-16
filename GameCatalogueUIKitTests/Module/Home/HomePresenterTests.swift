//
//  HomePresenterTests.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 07/01/26.
//

import Combine
import XCTest

@testable import game_catalogue_uikit
import Core
import Home

@MainActor
final class HomePresenterTests: XCTestCase {

    var sut: HomePresenter!
    var mockUseCase: MockHomeUseCase!
    var mockView: MockHomeView!

    override func setUp() {
        super.setUp()
        mockUseCase = MockHomeUseCase()
        mockView = MockHomeView()

        sut = HomePresenter(homeUseCase: mockUseCase)
        sut.attachView(mockView)
    }

    override func tearDown() {
        sut = nil
        mockUseCase = nil
        mockView = nil
        super.tearDown()
    }

    func test_loadInitial_success_shouldUpdateView() {
        // Given
        let games = [MockData.sampleGame]
        mockUseCase.result = .success(games)

        let expectation = XCTestExpectation(
            description: "View updated on success"
        )
        mockView.expectation = expectation

        // When
        sut.loadInitial()

        wait(for: [expectation], timeout: 1.0)

        // Then
        XCTAssertTrue(mockView.isSuccessCalled)
        XCTAssertFalse(mockView.isLoadingCalled)
        XCTAssertEqual(sut.games.count, 1)
        XCTAssertEqual(sut.games.first?.name, "Test Game")
    }

    func test_loadInitial_failure_shouldShowError() {
        // Given
        let error = URLError(.notConnectedToInternet)
        mockUseCase.result = .failure(error)

        let expectation = XCTestExpectation(
            description: "View updated on failure"
        )
        mockView.expectation = expectation

        // When
        sut.loadInitial()

        wait(for: [expectation], timeout: 3.0)

        // Then
        XCTAssertTrue(mockView.isFailedCalled)
        XCTAssertEqual(mockView.errorMessage, error.localizedDescription)
    }

    func test_loadNextPage_success_shouldAppendData() {
        // Given
        let initialGame = MockData.sampleGame

        let newGame = Game(
            id: 2,
            name: "New Game",
            released: "",
            backgroundImage: nil,
            rating: 0,
            ratingCount: 0,
            platforms: [],
            genres: [],
            description: nil,
            added: nil,
            developers: nil
        )

        mockUseCase.result = .success([newGame])

        // When
        sut.loadNextPage()

        let expectation = XCTestExpectation(description: "Next page loaded")
        mockView.expectation = expectation

        wait(for: [expectation], timeout: 0.5)

        // Then
        XCTAssertTrue(mockView.isSuccessCalled)
        XCTAssertEqual(sut.games.count, 1)
        XCTAssertEqual(sut.games.last?.name, "New Game")
    }

    func test_searchQueryChanged_shouldTriggerSearch() {
        // Given
        let searchGame = Game(
            id: 3,
            name: "Search Result",
            released: "",
            backgroundImage: nil,
            rating: 0,
            ratingCount: 0,
            platforms: [],
            genres: [],
            description: nil,
            added: nil,
            developers: nil
        )
        mockUseCase.result = .success([searchGame])

        let expectation = XCTestExpectation(description: "Search loaded")
        mockView.expectation = expectation

        // When
        sut.searchQueryChanged("God of War")

        wait(for: [expectation], timeout: 1.0)

        // Then
        XCTAssertTrue(mockView.isSuccessCalled)
        XCTAssertEqual(sut.games.first?.name, "Search Result")
    }
}
