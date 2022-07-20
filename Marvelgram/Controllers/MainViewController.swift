//
//  MainViewController.swift
//  Marvelgram
//
//  Created by Tim Akhm on 07.02.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
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
    
    private let searchController = UISearchController()
    
    private let idCollectionView = "idCollectionView"
    private var heroesArray = [HeroMarvelModel]()
    
    private var isFiltred = false
    private var filtredArray = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getHeroesArray()
        setupViews()
        setDelegates()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.1516073942, green: 0.1516073942, blue: 0.1516073942, alpha: 1)
        setupNavigationBar()
        view.addSubview(collectionView)
        collectionView.register(HeroesCollectionViewCell.self, forCellWithReuseIdentifier: idCollectionView)
    }
     
    private func setupNavigationBar() {
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        navigationItem.backButtonTitle = ""
        navigationItem.titleView = createCustomTitleView()
        navigationItem.hidesSearchBarWhenScrolling = false
        
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.standardAppearance.backgroundColor = #colorLiteral(red: 0.1516073942, green: 0.1516073942, blue: 0.1516073942, alpha: 1)
            navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = #colorLiteral(red: 0.1516073942, green: 0.1516073942, blue: 0.1516073942, alpha: 1)
        }
    }
    
    private func setDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.delegate = self
    }
    
    private func getHeroesArray() {
        
        NetworkDataFetch.shared.fetchHero { [weak self] heroMarvelArray, error in
            guard let self = self else { return }
            if error != nil {
                print("show alert")
            } else {
                guard let heroMarvelArray = heroMarvelArray else { return }
                self.heroesArray = heroMarvelArray
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setAlphaForCell(alpha: Double) {
        collectionView.visibleCells.forEach { cell in
            cell.alpha = alpha
        }
    }
    
    private func createCustomTitleView() -> UIView {
        let view = UIView()
        let heightNavBar = navigationController?.navigationBar.frame.height ?? 0
        let widthNavBar = navigationController?.navigationBar.frame.width ?? 0
        view.frame = CGRect(x: 0, y: 0, width: widthNavBar, height: heightNavBar - 10)
        
        let marvelImageView = UIImageView()
        marvelImageView.image = UIImage(named: "marvelLogo")
        marvelImageView.contentMode = .left
        marvelImageView.frame = CGRect(x: 10, y: 0, width: widthNavBar , height: heightNavBar / 2)
        view.addSubview(marvelImageView)
        return view
    }
}

//MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        heroesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCollectionView, for: indexPath) as! HeroesCollectionViewCell
        let heroModel = heroesArray[indexPath.row]
        cell.cellConfigure(model: heroModel)
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let heroModel = heroesArray[indexPath.row]
        let detailsHeroViewController = DetailsHeroViewController()
        detailsHeroViewController.heroModel = heroModel
        detailsHeroViewController.heroesArray = heroesArray
        navigationController?.pushViewController(detailsHeroViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isFiltred {
            cell.alpha = (filtredArray.contains(indexPath) ? 1 : 0.3)
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: collectionView.frame.width / 3.02,
               height: collectionView.frame.width / 3.02)
    }
}

// MARK: - UISearchResultsUpdating

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filterContentForSearchText(text)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        for (value, hero) in heroesArray.enumerated() {
            let indexPath: IndexPath = [0, value]
            let cell = collectionView.cellForItem(at: indexPath)
            if hero.name.lowercased().contains(searchText.lowercased()) {
                filtredArray.append(indexPath)
                cell?.alpha = 1
            } else {
                cell?.alpha = 0.3
            }
        }
    }
}

//MARK: - UISearchControllerDelegate

extension MainViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        isFiltred = true
        setAlphaForCell(alpha: 0.3)
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        isFiltred = false
        setAlphaForCell(alpha: 1) 
        self.collectionView.reloadData()
    }
}

//MARK: - SetConstraints

extension MainViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
