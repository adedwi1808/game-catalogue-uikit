//
//  Data+Extension.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 23/11/25.
//

import Foundation
import UniformTypeIdentifiers

extension Data {
    var mimeType: String {
        var byte: [UInt8] = [0]
        copyBytes(to: &byte, count: 1)

        switch byte[0] {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x49, 0x4D:
            return "image/tiff"
        case 0x25:
            return "application/pdf"
        case 0xD0:
            return "application/vnd.ms-powerpoint"
        case 0x46:
            return "text/plain"
        default:
            return "application/octet-stream"
        }
    }

    var fileExtension: String {
        switch mimeType {
        case "image/jpeg": return "jpg"
        case "image/png": return "png"
        case "image/gif": return "gif"
        case "image/tiff": return "tiff"
        case "application/pdf": return "pdf"
        case "application/vnd.ms-powerpoint": return "ppt"
        case "text/plain": return "txt"
        default: return "bin"
        }
    }
}

extension URL {
    public func mimeType() -> String {
        if let mimeType = UTType(filenameExtension: self.pathExtension)?.preferredMIMEType {
            return mimeType
        } else {
            return "application/octet-stream"
        }
    }
}
