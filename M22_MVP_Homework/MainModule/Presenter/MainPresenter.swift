//
//  FilmPresenter.swift
//  M22_MVP_Homework
//
//  Created by Sergey Savinkov on 28.11.2023.
//

import Foundation

protocol MainFilmView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func searchKeyFilm(_ filmArray: [FilmSerchResult])
    func topWaitSearch(_ filmArray:[TopRating])
    func setEmpty()
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: ViewController,
         networkService: ServiceManager)
    
    func searchFilm(text: String)
    func topRatingSearch(url: String, page: Int)
    func getCellViewModel(at indexPath: IndexPath) -> FilmSerchResult
    func getTopCellViewModel(at indexPath: IndexPath) -> TopRating
    
    var reloadTableView: (() -> Void)? { get set }
    var currentPage: Int { get set }
    var topFilmCellViewModels: [TopRating] { get set }
    var filmCellViewModels: [FilmSerchResult] { get set }
    
}

class MainPresenter: MainViewPresenterProtocol  {
    weak var filmView: MainFilmView?
    let networkService: ServiceManager
    var reloadTableView: (() -> Void)?
    var currentPage = 1
    
    
    var filmCellViewModels = [FilmSerchResult]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var topFilmCellViewModels = [TopRating]() {
        didSet {
            reloadTableView?()
        }
    }
    
    required init(view: ViewController, networkService: ServiceManager) {
        self.filmView = view
        self.networkService = networkService
    }
    
    func searchFilm(text: String) {
        filmView?.startLoading()
        if text.count != 0 {
            networkService.searchKeywordFilm(with: text) { [weak self] result in
                guard let self = self else { return }
                switch result {
                    
                case .success(let film):
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        self.filmView?.searchKeyFilm(film)
                        self.filmView?.finishLoading()
                    }
                case .failure(let error):
                    print(error)
                    self.filmView?.finishLoading()
                    self.filmView?.setEmpty()
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.filmView?.finishLoading()
                self.filmView?.setEmpty()
            }
        }
    }
    
    func topRatingSearch(url: String, page: Int) {
        filmView?.startLoading()
        
        networkService.getTopFilms(urlString: url, page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let film):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8)  {
                    if page == 1 {
                        self.topFilmCellViewModels.removeAll()
                        self.filmView?.topWaitSearch(film)
                    } else {
                        self.topFilmCellViewModels += film
                    }
                    
                    self.filmView?.finishLoading()
                }
            case .failure(let error):
                print(error)
                self.filmView?.finishLoading()
                self.filmView?.setEmpty()
            }
        }
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> FilmSerchResult {
        return filmCellViewModels[indexPath.row]
    }
    
    func getTopCellViewModel(at indexPath: IndexPath) -> TopRating {
        return topFilmCellViewModels[indexPath.row]
    }
}
