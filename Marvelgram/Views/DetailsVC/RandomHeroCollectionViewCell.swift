//
//  RandomHeroCollectionViewCell.swift
//  Marvelgram
//
//  Created by Tim Akhm on 07.02.2022.
//

import UIKit

class RandomHeroCollectionViewCell: UICollectionViewCell {
    
    let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        backgroundColor = .none
        addSubview(heroImageView)
    }
    
    func cellConfigure(model: HeroMarvelModel) {
        guard let url = model.thumbnail.url else { return }
        NetworkImageFetch.shared.requestImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                self.heroImageView.image = image
            case .failure(_):
                print("AlertHere")
            }
        }
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            heroImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            heroImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            heroImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}
