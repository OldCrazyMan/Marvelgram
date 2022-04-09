//
//  HeroMarvelModel.swift
//  Marvelgram
//
//  Created by Тимур Ахметов on 07.02.2022.
//

import Foundation

struct HeroMarvelModel: Decodable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnail: Thumbnail
}

struct Thumbnail: Decodable {
    let path: String
    let `extension`: String
    var url: URL? {
        return URL(string: path + "." + `extension`)
    }
}
