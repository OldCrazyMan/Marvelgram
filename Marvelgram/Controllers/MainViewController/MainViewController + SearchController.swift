//
//  MainViewController + SearchController.swift
//  Marvelgram
//
//  Created by Tim Akhmetov on 26.01.2024.
//

import UIKit

extension MainViewController {
    
    func setupNavigationBar() {
        searchController.searchResultsUpdater = self
        searchController.delegate = self
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

// MARK: - UISearchResultsUpdating

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filterContentForSearchText(text)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        for (value, hero) in heroesDataSource.enumerated() {
            let indexPath: IndexPath = [0, value]
            let cell = mainCollectionView.cellForItem(at: indexPath)
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
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        isFiltred = false
        self.mainCollectionView.reloadData()
    }
}
