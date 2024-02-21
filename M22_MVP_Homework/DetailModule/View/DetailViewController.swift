//
//  TableViewCell.swift
//  KinoBOX
//
//  Created by Sergey Savinkov on 12.10.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let rateKinoLabel = UILabel(
        text: "KINOPOISK",
        font: .systemFont(ofSize: 12),
        color: .black,
        line: 1)
    
    private let rateNumberKinoLabel = UILabel(
        text: "",
        font: .systemFont(ofSize: 12),
        color: .black,
        line: 1)
    
    private let rateIMDBLabel = UILabel(
        text: "IMDB",
        font: .systemFont(ofSize: 12),
        color: .black,
        line: 1)
    
    private let rateNumberIMDBLabel = UILabel(
        text: "",
        font: .systemFont(ofSize: 12),
        color: .black,
        line: 1)
    
    private let nameLabel = UILabel(
        text: "",
        font: .boldSystemFont(ofSize: 20),
        color: .black,
        line: 0)
    
    private let nameRealLabel = UILabel(
        text: "",
        font: .systemFont(ofSize: 18),
        color: .gray,
        line: 0)
    
    
    private let descriptionLabel = UILabel(
        text: "",
        font: .systemFont(ofSize: 12),
        color: .black,
        line: 0)
    
    private let yearLabel = UILabel(
        text: "Год производства",
        font: .systemFont(ofSize: 12),
        color: .gray,
        line: 1)
    
    private let yearNumberLabel = UILabel(
        text: "",
        font: .boldSystemFont(ofSize: 20),
        color: .black,
        line: 0)
    
    private let continLabel = UILabel(
        text: "Продолжительность",
        font: .systemFont(ofSize: 12),
        color: .gray,
        line: 1)
    
    private let continNumberLabel = UILabel(
        text: "",
        font: .boldSystemFont(ofSize: 20),
        color: .black,
        line: 0)
    
    private var rateStackView = UIStackView()
    private var rateIMDBStackView = UIStackView()
    private var nameStackView = UIStackView()
    private var yearStackView = UIStackView()
    private var contStackView = UIStackView()
    
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.idSearch()
        setupView()
        setupConstraints()
    }
    
    private func setupStackView() {
        rateStackView = UIStackView(
            addArrangedSubview: [rateKinoLabel,
                                 rateNumberKinoLabel],
            axis: .vertical,
            spacing: 2,
            aligment: .center,
            destribution: .equalCentering)
        
        rateIMDBStackView = UIStackView(
            addArrangedSubview: [rateIMDBLabel,
                                 rateNumberIMDBLabel],
            axis: .vertical,
            spacing: 2,
            aligment: .center,
            destribution: .equalCentering)
        
        nameStackView = UIStackView(
            addArrangedSubview: [nameLabel,
                                 nameRealLabel],
            axis: .vertical,
            spacing: 2,
            aligment: .center,
            destribution: .equalCentering)
        
        yearStackView = UIStackView(
            addArrangedSubview: [yearLabel,
                                 yearNumberLabel],
            axis: .vertical,
            spacing: 2,
            aligment: .center,
            destribution: .equalCentering)
        
        contStackView = UIStackView(
            addArrangedSubview: [continLabel,
                                 continNumberLabel],
            axis: .vertical,
            spacing: 2,
            aligment: .center,
            destribution: .equalCentering)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        setupStackView()
        
        view.addSubview(scrollView)
        scrollView.addSubview(posterImageView)
        scrollView.addSubview(rateStackView)
        scrollView.addSubview(rateIMDBStackView)
        scrollView.addSubview(nameStackView)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(yearStackView)
        scrollView.addSubview(contStackView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            posterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            posterImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
            
            rateStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
            rateStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            rateStackView.heightAnchor.constraint(equalToConstant: 50),
            
            rateIMDBStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
            rateIMDBStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            rateIMDBStackView.heightAnchor.constraint(equalToConstant: 50),
            
            nameStackView.topAnchor.constraint(equalTo: rateIMDBStackView.bottomAnchor, constant: 10),
            nameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nameStackView.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            yearStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            yearStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            yearStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            yearStackView.heightAnchor.constraint(equalToConstant: 50),
            
            contStackView.topAnchor.constraint(equalTo: yearStackView.bottomAnchor, constant: 10),
            contStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            contStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            contStackView.heightAnchor.constraint(equalToConstant: 50),
            contStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    
    func search2IDFilm() {
        
    }
}

extension DetailViewController: DetailViewProtocol {
    
    func setFilm(film: IdFilmSerchResult?) {
        guard let film = film else { return }
        
        let kinopoiskRate = film.ratingKinopoisk ?? 0
        let IMDBRate = film.ratingImdb ?? 0
        let filmLength = film.filmLength ?? 0
        
        rateNumberKinoLabel.text = "\(kinopoiskRate)"
        rateNumberIMDBLabel.text = "\(IMDBRate)"
        
        nameLabel.text = film.nameRu
        nameRealLabel.text = film.nameEn
        
        if film.description == nil || film.description == "" {
            descriptionLabel.text = "Описание фильма отсутствует"
        } else {
            descriptionLabel.text = film.description
        }
        
        yearNumberLabel.text = "\(String(describing: film.year))"
        continNumberLabel.text = "\(filmLength) мин."
        
        let urlString = film.posterUrl
        guard let url = URL(string: urlString) else { return }
        
        ServiceManager.shared.requestImage(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let data):
                let image = UIImage(data: data)
                self.posterImageView.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
}
