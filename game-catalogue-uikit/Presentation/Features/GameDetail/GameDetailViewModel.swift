//
//  GameDetailViewModel.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//

import Foundation

protocol GameDetailViewModelProtocol: AnyObject {
    func onSuccess()
    func onFailed(message: String)
}

@MainActor
final class GameDetailViewModel {
    var data: Game? = nil
    
    weak var delegate: GameDetailViewModelProtocol? = nil
    
    private let services: GameDetailServicesProtocol
    
    init(services: GameDetailServicesProtocol) {
        self.services = services
    }
    
    func configureDataFromList(data: Game) {
        self.data = data
    }
    
    func getGameDetail() async {
        do {
            guard let id = data?.id else { throw GeneralError.runtimeError("Cannot Find Id") }
            
            let respose = try await services.getGameDetail(endPoint: .getGameDetail(id: id))
            data = respose.toDomain()
            delegate?.onSuccess()
        } catch let error {
            delegate?.onFailed(message: error.localizedDescription)
        }
    }
}
