//
//  HeroCollectionCellViewModel.swift
//  Marvelgram
//
//  Created by Tim Akhmetov on 26.01.2024.
//

import Foundation

class HeroCollectionCellViewModel {
    var id: Int
    var name: String
    var description: String
    var image: URL?
    
    init(hero: HeroMarvelModel) {
        self.id = hero.id
        self.name = hero.name
        self.description = hero.description
        self.image = hero.thumbnail.url
    }
}

extension HeroCollectionCellViewModel: Hashable {
    static func == (lhs: HeroCollectionCellViewModel, rhs: HeroCollectionCellViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
