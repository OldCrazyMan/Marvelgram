//
//  DetailsHeroViewController.swift
//  Marvelgram
//
//  Created by Tim Akhm on 07.02.2022.
//

import UIKit

final class DetailsHeroViewController: UIViewController {
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let exploreMoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Explore more:"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    var viewModel: DetailsHeroViewModel
    var detailHeroesDataSource: [HeroCollectionCellViewModel] = []
    
    init(viewModel: DetailsHeroViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeroInfo()
        setupViews()
        setCollectionView()
        viewModel.getRandomHeroes()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.1516073942, green: 0.1516073942, blue: 0.1516073942, alpha: 1)
        view.addSubview(scrollView)
        scrollView.addSubview(heroImageView)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(exploreMoreLabel)
        scrollView.addSubview(detailCollectionView)
        
        navigationController?.navigationBar.tintColor = .white
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
    
    private func setupHeroInfo() {
        title = viewModel.heroTitle
        detailHeroesDataSource = viewModel.detailHeroes
        descriptionLabel.text = viewModel.heroDescription
        if descriptionLabel.text == "" {
            descriptionLabel.text = "The data on this hero is classified as 'TOP SECRET'"
        }
        
        guard let url = viewModel.heroImage else { return }
        NetworkImageFetch.shared.requestImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                self.heroImageView.image = image
            case .failure(let error):
                print("DetailsVC error:\(error.localizedDescription)")
            }
        }
    }
}

//MARK: - SetConstraints

extension DetailsHeroViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.heightAnchor.constraint(equalToConstant: view.frame.height),
            scrollView.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            heroImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            heroImageView.widthAnchor.constraint(equalToConstant: view.frame.width),
            heroImageView.heightAnchor.constraint(equalToConstant: view.frame.width),
            
            descriptionLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            exploreMoreLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            exploreMoreLabel.bottomAnchor.constraint(equalTo: detailCollectionView.topAnchor, constant: -5),
            exploreMoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            exploreMoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            detailCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            detailCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            detailCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            detailCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
        ])
    }
}
