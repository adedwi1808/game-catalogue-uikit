//
//  Platform.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//


enum Platform: String, Codable {
    case pc, mac, linux, web, android, ios, nintendo
    case playStation = "playstation"
    case xbox
    case unknown
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = Platform(rawValue: (try? container.decode(String.self)) ?? "") ?? .unknown
    }
    
    var assetName: String {
        switch self {
        case .pc: return "IconPC"
        case .mac: return "IconApple"
        case .linux: return "IconLinux"
        case .web: return "IconWeb"
        case .android: return "IconAndroid"
        case .ios: return "IconiOS"
        case .nintendo: return "IconNintendo"
        case .playStation: return "IconPlayStation"
        case .xbox: return "IconXbox"
        case .unknown: return "IconUnknown"
        }
    }
}
