//
//  FilmCellViewModel.swift
//  M22_MVP_Homework
//
//  Created by Sergey Savinkov on 12.10.2023.
//

import Foundation

class FilmCellViewModel {
    var filmId: Int
    var nameRu: String?
    var nameEn: String?
    var posterUrl: String
    
    init(filmId: Int, nameRu: String? = nil, nameEn: String? = nil, posterUrl: String) {
        self.filmId = filmId
        self.nameRu = nameRu
        self.nameEn = nameEn
        self.posterUrl = posterUrl
    }
}

