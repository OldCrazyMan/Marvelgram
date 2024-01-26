//
//  MainViewController.swift
//  Marvelgram
//
//  Created by Tim Akhm on 07.02.2022.
//

import UIKit

final class MainViewController: UIViewController {
    let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let searchController = UISearchController()
    var isFiltred = false
    var filtredArray = [IndexPath]()
    var viewModel: MainViewModel = MainViewModel()
    var heroesDataSource: [HeroCollectionCellViewModel] = []
    
    private let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViewModel()
    }
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.1516073942, green: 0.1516073942, blue: 0.1516073942, alpha: 1)
        view.addSubview(mainCollectionView)
        view.addSubview(activityIndicator)
        
        setupNavigationBar()
        setCollectionView()
    }
    
    private func bindViewModel() {
        
        viewModel.isLoadingData.bind { [weak self] isLoading in
            guard let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.heroes.bind { [weak self] heroes in
            guard let self = self,
                  let heroes = heroes else {
                return
            }
            self.heroesDataSource = heroes
            print(heroes)
            self.reloadCollectionView()
        }
    }
}
