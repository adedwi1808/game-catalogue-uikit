//
//  Array+GameResponse.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//

import Foundation

extension Array where Element == GamesResponse {
    func toDomain() -> [Game] {
        self.map { $0.toDomain() }
    }
}
