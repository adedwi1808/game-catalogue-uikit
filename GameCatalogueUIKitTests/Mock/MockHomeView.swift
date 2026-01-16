//
//  MockHomeView.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 07/01/26.
//

import Combine
import Foundation
import XCTest
import Home

@testable import game_catalogue_uikit

class MockHomeView: HomeViewProtocol {
    var isSuccessCalled = false
    var isFailedCalled = false
    var isLoadingCalled = false
    var errorMessage: String?

    var expectation: XCTestExpectation?

    func onSuccess() {
        isSuccessCalled = true
        expectation?.fulfill()
    }

    func onFailed(message: String) {
        isFailedCalled = true
        errorMessage = message
        expectation?.fulfill()
    }

    func onLoading(_ isLoading: Bool) {
        isLoadingCalled = isLoading
    }
}
