//
//  Model.swift
//  M22_MVP_Homework
//
//  Created by Sergey Savinkov on 22.11.2023.
//

import Foundation

struct SearchFilm: Codable {
    var keyword: String
    var pagesCount: Int
    var films: [FilmSerchResult]
}

struct FilmSerchResult: Codable {
    var filmId: Int
    var nameRu: String?
    var nameEn: String?
    var posterUrl: String
}

struct TopResult: Codable {
    var pagesCount: Int
    var films: [TopRating]
}

struct TopRating: Codable {
    var filmId: Int
    var nameRu: String?
    var nameEn: String?
    var posterUrl: String
}

