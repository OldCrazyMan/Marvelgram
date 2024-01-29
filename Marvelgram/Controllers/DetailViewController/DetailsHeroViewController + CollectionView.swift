//
//  DetailsHeroViewController + CollectionView.swift
//  Marvelgram
//
//  Created by Tim Akhmetov on 26.01.2024.
//

import UIKit

extension DetailsHeroViewController: UICollectionViewDelegate {
    
    func setCollectionView() {
        self.detailCollectionView.dataSource = self
        self.detailCollectionView.delegate = self
        self.registerCells()
    }
    
    private func registerCells() {
        self.detailCollectionView.register(HeroesCollectionViewCell.self, forCellWithReuseIdentifier: HeroesCollectionViewCell.idCollectionView)
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.detailCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
     //   let heroModel = detailHeroesDataSource[indexPath.row]
        
        //let detailsHeroViewController = DetailsHeroViewController()
     //   detailsHeroViewController.heroModel = heroModel
     //   detailsHeroViewController.heroesArray = heroesArray
     //   navigationController?.pushViewController(detailsHeroViewController, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension DetailsHeroViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.height,
               height: collectionView.frame.height)
    }
}

//MARK: - UICollectionViewDataSource

extension DetailsHeroViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroesCollectionViewCell.idCollectionView,
                                                            for: indexPath) as? HeroesCollectionViewCell else { return UICollectionViewCell() }
        let heroModel = viewModel.randomHeroesArray[indexPath.row]
        cell.cellConfigure(model: heroModel)
        return cell
    }
}
