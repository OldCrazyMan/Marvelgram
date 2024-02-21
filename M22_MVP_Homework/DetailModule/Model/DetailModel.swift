//
//  DetailModel.swift
//  M22_MVP_Homework
//
//  Created by Sergey Savinkov on 12.10.2023.
//

import Foundation

struct IdFilmSerchResult: Codable {
    var kinopoiskId: Int
    var nameRu: String?
    var nameEn: String?
    var description: String?
    var year: Int
    var filmLength: Int?
    var ratingKinopoisk: Double?
    var ratingImdb: Double?
    var posterUrl: String
}
