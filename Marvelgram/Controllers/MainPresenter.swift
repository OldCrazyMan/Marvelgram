//
//  MainPresenter.swift
//  Marvelgram
//
//  Created by Tim Akhmetov on 26.01.2024.
//

import Foundation

protocol MainFilmView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func getArray(_ array: [HeroMarvelModel])
    func setEmpty()
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewController,
         networkService: NetworkDataFetch)
    
    func getCellViewModel(at indexPath: IndexPath) -> HeroMarvelModel

    var reloadTableView: (() -> Void)? { get set }
    var heroesCellViewModels: [HeroMarvelModel] { get set }
    
}

class MainPresenter: MainViewPresenterProtocol  {
    let networkService: NetworkDataFetch
    weak var heroView: MainFilmView?
    
    var reloadTableView: (() -> Void)?
    var heroesCellViewModels = [HeroMarvelModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    required init(view: MainViewController, networkService: NetworkDataFetch) {
        self.heroView = view
        self.networkService = networkService
    }
    

    func getCellViewModel(at indexPath: IndexPath) -> FilmSerchResult {
        return filmCellViewModels[indexPath.row]
    }
    
}
