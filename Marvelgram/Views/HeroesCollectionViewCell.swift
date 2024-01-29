//
//  HeroesCollectionViewCell.swift
//  Marvelgram
//
//  Created by Tim Akhm on 07.02.2022.
//

import UIKit

final class HeroesCollectionViewCell: UICollectionViewCell {
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    static var idCollectionView: String {
        get {
            "idCollectionView"
        }
    }
    
    override func prepareForReuse() {
        heroImageView.image = nil
    }
    
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
    
    func cellConfigure(model: HeroCollectionCellViewModel) {
        guard let url = model.image else { return }
        self.setImage(with: url)
    }
    
    private func setImage(with url: URL) {
        NetworkImageFetch.shared.requestImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                self.heroImageView.image = image
            case .failure(let error):
                print("CellConfig error:\(error.localizedDescription)")
            }
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            heroImageView.widthAnchor.constraint(equalToConstant: frame.width),
            heroImageView.heightAnchor.constraint(equalToConstant: frame.height),
        ])
    }
}
