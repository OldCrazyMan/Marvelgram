//
//  MainViewController.swift
//  Marvelgram
//
//  Created by Tim Akhm on 07.02.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    var isFiltred = false
    var filtredArray = [IndexPath]()
    var viewModel: ViewModelProtocol
    var heroesDataSource: [HeroCollectionCellViewModel] = []
    let searchController = UISearchController()
    
    let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.hidesWhenStopped = true
        return activityView
    }()
    
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        setupViews()
    }
    
    private func setupViews() {
        viewModel.getData()
        setupNavigationBar()
        setCollectionView()
        
        view.backgroundColor = #colorLiteral(red: 0.1516073942, green: 0.1516073942, blue: 0.1516073942, alpha: 1)
        view.addSubview(mainCollectionView)
        view.addSubview(activityIndicator)
        
        activityIndicator.center = view.center
    }
    
    private func bindViewModel() {
        viewModel.isLoadingData.bind { [weak self] isLoading in
            guard let isLoading = isLoading else { return }
            
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
                  let heroes = heroes else { return }
            
            self.heroesDataSource = heroes
            self.reloadCollectionView()
        }
    }
    
    func openDetails(id: Int) {
        guard let hero = viewModel.retriveHero(withId: id) else {
            return
        }
        
        DispatchQueue.main.async {
            let detailsViewModel = DetailsHeroViewModel(hero: hero, randomArray: self.heroesDataSource)
            let controller = DetailsHeroViewController(viewModel: detailsViewModel)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
