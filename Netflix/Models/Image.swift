//
//  Image.swift
//  Netflix
//
//  Created by SERDAR TURAN on 20.12.2020.
//

import Foundation

struct ImageResponse: Codable {
    let results: [ImageResult]?

    enum CodingKeys: String, CodingKey {
        case results = "RESULTS"
    }
}

struct ImageResult: Codable {
    let image: [Image]?
}

struct Image: Codable {
    let type: ImageType?
    let url: String?
    let height, width: String?
}

enum ImageType: String, Codable {
    case background = "background"
    case billboard = "billboard"
    case boxart = "boxart"
    case bleedback = "bleedback"
}
