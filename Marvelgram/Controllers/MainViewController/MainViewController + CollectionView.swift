//
//  MainViewController + CollectionView.swift
//  Marvelgram
//
//  Created by Tim Akhmetov on 26.01.2024.
//

import UIKit

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func setCollectionView() {
        self.mainCollectionView.frame = view.bounds
        self.mainCollectionView.dataSource = self
        self.mainCollectionView.delegate = self
        self.registerCells()
    }
    
    private func registerCells() {
        self.mainCollectionView.register(HeroesCollectionViewCell.self, forCellWithReuseIdentifier: HeroesCollectionViewCell.idCollectionView)
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroesCollectionViewCell.idCollectionView, for: indexPath) as? HeroesCollectionViewCell else { return UICollectionViewCell() }
        
        let heroModel = heroesDataSource[indexPath.row]
        cell.cellConfigure(model: heroModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let heroId = heroesDataSource[indexPath.row].id
        self.openDetails(id: heroId)
        
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
