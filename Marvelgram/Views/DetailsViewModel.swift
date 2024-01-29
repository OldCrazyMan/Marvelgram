//
//  DetailsViewModel.swift
//  Marvelgram
//
//  Created by Tim Akhmetov on 26.01.2024.
//

import UIKit

class DetailsHeroViewModel {
    var detailHeroes: [HeroCollectionCellViewModel] = []
    var randomHeroesArray: [HeroCollectionCellViewModel] = []
    
    var heroImage: URL?
    var heroTitle: String
    var heroDescription: String
    var heroId: Int
    
    init(hero: HeroMarvelModel, randomArray: [HeroCollectionCellViewModel]) {
        self.detailHeroes = randomArray
        self.heroId = hero.id
        self.heroTitle = hero.name
        self.heroDescription = hero.description
        self.heroImage = hero.thumbnail.url
    }
    
    func numberOfItems(in section: Int) -> Int {
        return randomHeroesArray.count
    }
    
    func getRandomHeroes()  {
        while randomHeroesArray.count < 8 {
            let randomInt = Int.random(in: 0...detailHeroes.count - 1)
          
            randomHeroesArray.append(detailHeroes[randomInt])
            let sortAr = Set(randomHeroesArray)
            randomHeroesArray = Array(sortAr)
        }
    }
}
