//
//  ModelBuilder.swift
//  M22_MVP_Homework
//
//  Created by Sergey Savinkov on 12.10.2023.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createDetailModule(filmID: Int) -> UIViewController
}

class ModelBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let view = ViewController()
        let networkService = ServiceManager()
        let presenter = MainPresenter(view: view, networkService: networkService)
        
        view.presenter = presenter
        return view
    }
    
    static func createDetailModule(filmID: Int) -> UIViewController {
        let view = DetailViewController()
        let networkService = ServiceManager()
        
        let presenter = DetailPresenter(view: view,
                                        networkService: networkService,
                                        filmID: filmID)
        view.presenter = presenter
        return view
    }
}
