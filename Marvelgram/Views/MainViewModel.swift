//
//  MainViewModel.swift
//  Marvelgram
//
//  Created by Tim Akhmetov on 26.01.2024.
//

import Foundation

protocol ViewModelProtocol {
    
    var isLoadingData: Observable<Bool> { get }
    var dataSource: [HeroMarvelModel] { get }
    var heroes: Observable<[HeroCollectionCellViewModel]> { get }
  
    func getData()
    func retriveHero(withId id: Int) -> HeroMarvelModel?
    func numberOfItems(in section: Int) -> Int
}

class MainViewModel: ViewModelProtocol {
   
    var isLoadingData: Observable<Bool> = Observable(false)
    var dataSource: [HeroMarvelModel] = []
    var heroes: Observable<[HeroCollectionCellViewModel]> = Observable(nil)
 
    func numberOfItems(in section: Int) -> Int {
        return dataSource.count
    }
    
    func getData() {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        
        NetworkDataFetch.shared.fetchHero { [weak self] heroMarvelArray, error in
            guard let self = self else { return }
            self.isLoadingData.value = false
            
            if error != nil {
                print("MainVC NetworkDataFetch error:\(String(describing: error?.localizedDescription))")
            } else {
                guard let heroMarvelArray = heroMarvelArray else { return }
                self.dataSource = heroMarvelArray
                mapHeroData()
            }
        }
    }
    
    private func mapHeroData() {
        heroes.value = self.dataSource.compactMap({HeroCollectionCellViewModel(hero: $0)})
    }
    
    func retriveHero(withId id: Int) -> HeroMarvelModel? {
        guard let hero = dataSource.first(where: {$0.id == id}) else {
            return nil
        }
        return hero
    }
}
