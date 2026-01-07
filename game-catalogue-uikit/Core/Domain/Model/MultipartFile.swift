//
//  MultipartFile.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 07/01/26.
//

import Foundation

struct MultipartFile {
    let paramName: String
    let data: Data
    let fileName: String
    let mimeType: String
}
