//
//  UIScreen+Extension.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//

import UIKit

extension UIScreen {
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }

    static var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
}
