//
//  DetailPresenter.swift
//  M22_MVP_Homework
//
//  Created by Sergey Savinkov on 12.10.2023.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func setFilm(film: IdFilmSerchResult?)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol,
         networkService: ServiceManager,
         filmID: Int)
    
    func idSearch()
}

class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    let networkService: ServiceManager
    var filmID: Int
    
    required init(view: DetailViewProtocol, networkService: ServiceManager, filmID: Int) {
        self.view = view
        self.networkService = networkService
        self.filmID = filmID
    }
    
    func idSearch() {
        networkService.getIdFilms(urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films/", filmID: filmID) { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let film):
                DispatchQueue.main.async {
                    self.view?.setFilm(film: film)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
