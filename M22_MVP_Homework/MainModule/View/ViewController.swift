//
//  ViewController.swift
//  M22_MVP_Homework
//
//  Created by Sergey Savinkov on 22.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
    enum Model {
        case keyword, top100, top250, topAwait
    }
    
    var tableModel = Model.keyword
    
    private let resultTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 180
        tableView.backgroundColor = .clear
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.text = nil
        textField.placeholder = "Введите название фильма"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always //
        textField.keyboardType = .default
        textField.returnKeyType = .default //
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let searchLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let top100Button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.setTitle("ТОП-100 фильмов", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.tag = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let top250Button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.setTitle("ТОП-250 фильмов", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.tag = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let topWaitButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.setTitle("ТОП Ожидаемых фильмов", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.tag = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private var searchController = UISearchController()
    var presenter: MainViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        setupeSearch()
        setTarget()
        setupDelegate()
        setupConstraints()
        
        resultTableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    //MARK: - setupViews
    
    private func setupViews() {
        view.addSubview(top100Button)
        view.addSubview(top250Button)
        view.addSubview(topWaitButton)
        view.addSubview(searchLabel)
        view.addSubview(spinner)
        view.addSubview(resultTableView)
    }
    
    //MARK: - setupDelegate
    
    private func setupDelegate() {
        resultTableView.dataSource = self
        resultTableView.delegate = self
    }
    
    //MARK: - setupConstraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            top100Button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            top100Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            top100Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            top100Button.heightAnchor.constraint(equalToConstant: 50),
            
            top250Button.topAnchor.constraint(equalTo: top100Button.bottomAnchor, constant: 10),
            top250Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            top250Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            top250Button.heightAnchor.constraint(equalToConstant: 50),
            
            topWaitButton.topAnchor.constraint(equalTo: top250Button.bottomAnchor, constant: 10),
            topWaitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            topWaitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            topWaitButton.heightAnchor.constraint(equalToConstant: 50),
            
            searchLabel.topAnchor.constraint(equalTo: topWaitButton.bottomAnchor, constant: 15),
            searchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            resultTableView.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 10),
            resultTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            resultTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            resultTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableModel {
        case .keyword:
            return presenter.filmCellViewModels.count
        case .top100:
            return presenter.topFilmCellViewModels.count
        case .top250:
            return presenter.topFilmCellViewModels.count
        case .topAwait:
            return presenter.topFilmCellViewModels.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        if tableModel == .keyword {
            let model = presenter.getCellViewModel(at: indexPath)
            cell.cellKeyViewModel = model
        } else {
            let model = presenter.getTopCellViewModel(at: indexPath)
            cell.cellTopViewModel = model
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableModel == .keyword {
            let model = presenter.getCellViewModel(at: indexPath)
            let detailVC = ModelBuilder.createDetailModule(filmID: model.filmId)
            navigationController?.pushViewController(detailVC, animated: true)
        } else {
            let model = presenter.getTopCellViewModel(at: indexPath)
            let detailVC = ModelBuilder.createDetailModule(filmID: model.filmId)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let height = scrollView.frame.size.height
        let contentOffSet = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if contentOffSet > contentHeight - height {
            
            presenter.currentPage += 1
            
            if tableModel == .top100 {
                presenter.topRatingSearch(url: URLString.ServerURL.top100URL.rawValue,
                                          page: presenter.currentPage)
            } else if tableModel == .top250 {
                presenter.topRatingSearch(url: URLString.ServerURL.top250URL.rawValue,
                                          page: presenter.currentPage)
            }
        }
        reloadTableView()
    }
}

//MARK: - ViewController

extension ViewController {
    
    private func setupeSearch() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Введите название фильма"
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    //MARK: - setTarget
    
    private func setTarget() {
        top100Button.addTarget(self, action: #selector(top100ButtonAction), for: .touchUpInside)
        top250Button.addTarget(self, action: #selector(top250ButtonAction), for: .touchUpInside)
        topWaitButton.addTarget(self, action: #selector(topWaitButtonAction), for: .touchUpInside)
    }
    
    //MARK: - reloadTableView
    
    private func reloadTableView() {
        presenter.reloadTableView = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.resultTableView.reloadData()
            }
        }
    }
    
    //MARK: - top100ButtonAction
    
    @objc private func top100ButtonAction() {
        searchLabel.text = "Топ 100 популярных фильмов"
        tableModel = .top100
        presenter.topRatingSearch(url: URLString.ServerURL.top100URL.rawValue, page: 1)
        
        reloadTableView()
    }
    
    //MARK: - top250ButtonAction
    
    @objc private func top250ButtonAction() {
        searchLabel.text = "Топ 250 популярных фильмов"
        tableModel = .top250
        presenter.topRatingSearch(url: URLString.ServerURL.top250URL.rawValue, page: 1)
        
        reloadTableView()
    }
    
    //MARK: - topWaitButtonAction
    
    @objc private func topWaitButtonAction() {
        searchLabel.text = "Топ ожидаемых фильмов"
        tableModel = .topAwait
        presenter.topRatingSearch(url: URLString.ServerURL.topAwaitURL.rawValue, page: 1)
        reloadTableView()
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else { return }
        
        if !text.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.tableModel = .keyword
                self.searchLabel.text = "Поиск по запросу: \"\(text)\""
                self.presenter.searchFilm(text: text)
                self.reloadTableView()
            }
        }
    }
}

extension ViewController: MainFilmView {
    
    func startLoading() {
        searchLabel.isHidden = true
        resultTableView.isHidden = true
        
        DispatchQueue.main.async {
            self.spinner.startAnimating()
        }
    }
    
    func finishLoading() {
        spinner.stopAnimating()
        searchLabel.isHidden = false
        resultTableView.isHidden = false
    }
    
    func searchKeyFilm(_ filmArray: [FilmSerchResult]) {
        presenter.filmCellViewModels = filmArray
    }
    
    func topWaitSearch(_ filmArray: [TopRating]) {
        presenter.topFilmCellViewModels = filmArray
    }
    
    func setEmpty() {
        searchLabel.text = "Произошла ошибка"
        searchLabel.isHidden = false
        resultTableView.isHidden = true
        self.spinner.stopAnimating()
    }
}

