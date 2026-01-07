//
//  AboutPresenter.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 07/01/26.
//

import Foundation

protocol AboutViewProtocol: AnyObject {
    func showProfile(_ profile: Profile)
    func setEditing(_ isEditing: Bool)
}

@MainActor
final class AboutPresenter {

    weak var view: AboutViewProtocol?

    private let interactor: AboutUseCase
    private(set) var isEditingProfile = false
    private var profile: Profile?

    init(interactor: AboutUseCase) {
        self.interactor = interactor
    }

    func viewDidLoad() {
        let profile = interactor.getProfile()
        self.profile = profile
        view?.showProfile(profile)
    }

    func editButtonTapped(
        currentName: String?,
        currentEmail: String?
    ) {
        if isEditingProfile {
            saveProfile(
                name: currentName ?? "",
                email: currentEmail ?? ""
            )
        }

        isEditingProfile.toggle()
        view?.setEditing(isEditingProfile)
    }

    private func saveProfile(name: String, email: String) {
        interactor.saveProfile(name: name, email: email)
        profile?.name = name
        profile?.email = email

        if let profile {
            view?.showProfile(profile)
        }
    }
}
