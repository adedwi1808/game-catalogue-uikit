//
//  GameDetailViewModel.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//

import Foundation

final class GameDetailViewModel {
    var data: Game? = nil
    
    func configureDataFromList(data: Game) {
        self.data = data
    }
}
