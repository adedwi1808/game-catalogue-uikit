//
//  AboutViewModel.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//

import Foundation

final class AboutViewModel {
    var name: String = "" {
        didSet {
            UserDefaults.name = name
        }
    }
    var email: String = "" {
        didSet {
            UserDefaults.email = email
        }
    }
    let imageURL: URL? = URL(string: "https://avatars.githubusercontent.com/u/56765011?v=4")
    
    var isEditingProfile = false

    
    init() {
        self.name = UserDefaults.name ?? "Ade Dwi Prayitno"
        self.email = UserDefaults.email ?? "adedwip1808@gmail.com"
    }
}
