//
//  Builder.swift
//  Marvelgram
//
//  Created by Tim Akhmetov on 26.01.2024.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
}

class ModelBuilder: Builder {
    static func createMainModule() -> UIViewController {
        
        let viewModel: ViewModelProtocol = MainViewModel()
        let view = MainViewController(viewModel: viewModel)
        view.viewModel = viewModel
        return view
    }
}
