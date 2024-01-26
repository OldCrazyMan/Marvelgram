//
//  MainPresenter.swift
//  Marvelgram
//
//  Created by Tim Akhmetov on 26.01.2024.
//

import Foundation

class √ {
    
    var isLoadingData: Observable<Bool> = Observable(false)
    var dataSource: [HeroMarvelModel]?
    var heroes: Observable<[HeroCollectionCellViewModel]> = Observable(nil)
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource?.count ?? 0
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
                mapMovieData()
            }
        }
    }
    
    private func mapMovieData() {
        heroes.value = self.dataSource?.compactMap({HeroCollectionCellViewModel(hero: $0)})
    }
    
    func getMovieTitle(_ hero: HeroMarvelModel) -> String {
        return hero.name
    }
    
    func retriveMovie(withId id: Int) -> HeroMarvelModel? {
        guard let movie = dataSource?.first(where: {$0.id == id}) else {
            return nil
        }
        
        return movie
    }
}
