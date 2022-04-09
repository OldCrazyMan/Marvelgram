//
//  MainViewController.swift
//  Marvelgram
//
//  Created by Тимур Ахметов on 07.02.2022.
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
    
    private var isFiltred = false //при нажатии на серчКонтроллер - становится true
    private var filtredArray = [IndexPath]() //добавляем индекспафы-номера ячеек
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setDelegates()
        setConstraints()
        getHeroesArray()
    }
    
    private func setupViews() {
        
        view.backgroundColor = #colorLiteral(red: 0.1516073942, green: 0.1516073942, blue: 0.1516073942, alpha: 1)
        
        setupNavigationBar()
        
        view.addSubview(collectionView)
        collectionView.register(HeroesCollectionViewCell.self, forCellWithReuseIdentifier: idCollectionView)
    }
    
    private func setupNavigationBar() { //настройки Серча
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController //добавили серч в навигейшнбар
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        navigationItem.backButtonTitle = ""
        navigationItem.titleView = createCustomTitleView() //происвоили тайтлвью метод
        navigationItem.hidesSearchBarWhenScrolling = false
        
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.standardAppearance.backgroundColor = #colorLiteral(red: 0.1516073942, green: 0.1516073942, blue: 0.1516073942, alpha: 1)
            navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = #colorLiteral(red: 0.1516073942, green: 0.1516073942, blue: 0.1516073942, alpha: 1)
        }
    }
    
    private func setDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //два делегата за появление-прекращение работы и действие при вводе в строку
        searchController.searchResultsUpdater = self
        searchController.delegate = self
    }
    
    private func getHeroesArray() {
        // извлекаем опционал и присваиваем массиву данные
        NetworkDataFetch.shared.fetchHero { [weak self] heroMarvelArray, error in //ослабили ссылку   
            guard let self = self else { return } //проверяем есть ссылка или нет
            if error != nil {
                print("show alert")
            } else {
                guard let heroMarvelArray = heroMarvelArray else { return }
                self.heroesArray = heroMarvelArray
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setAlphaForCell(alpha: Double) { //инвиз для каждого вызванного в коллекции, которые мы видим
        collectionView.visibleCells.forEach { cell in //перебираем  с помощью форИч
            cell.alpha = alpha
        }
    }
    
    private func createCustomTitleView() -> UIView { //создали вью и поместили на него тайтлбар марвел
        let view = UIView()
        let heightNavBar = navigationController?.navigationBar.frame.height ?? 0 // ?? - если нет навигейшнбара, то значние по-умолчанию 0
        let widthNavBar = navigationController?.navigationBar.frame.width ?? 0 //ширина навигейшнбара
        view.frame = CGRect(x: 0, y: 0, width: widthNavBar, height: heightNavBar - 10) //размеры фрейма
        
        //Установка лого Марвел во вью
        let marvelImageView = UIImageView()
        marvelImageView.image = UIImage(named: "marvelLogo")
        marvelImageView.contentMode = .left
        marvelImageView.frame = CGRect(x: 10, y: 0, width: widthNavBar , height: heightNavBar / 2)
        view.addSubview(marvelImageView) //накинули имейджвью на тайтл
        return view
    }
}

//MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    //numberOfItemsInSection - возвращает кол-во ячеек равное кол-ву элемента массива
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        heroesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //создаем переиспользованную ячейку, indexPath - определяет ее номер 0-49 и создаем кастомную ячейку в HerColVievCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCollectionView, for: indexPath) as! HeroesCollectionViewCell
        //получение конкретной модели из массива 0,0 0,1
        let heroModel = heroesArray[indexPath.row]
        cell.cellConfigure(model: heroModel)
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { //дидселект - нажатие на ячейку
        let heroModel = heroesArray[indexPath.row]
        
        //создаем переход/делаем экземпляр класса+в нем 2свойства в detailHero...VC
        let detailsHeroViewController = DetailsHeroViewController()
        detailsHeroViewController.heroModel = heroModel
        detailsHeroViewController.heroesArray = heroesArray
        navigationController?.pushViewController(detailsHeroViewController, animated: true) //кнопка "назад"
    }
    //виллДисплей-отрабатывает, как ячейка будет отображена
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isFiltred { //если мы находимся в режиме фильтрации, то:
            cell.alpha = (filtredArray.contains(indexPath) ? 1 : 0.3)
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout - отрисовка коллекции вью с картинками

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: collectionView.frame.width / 3.02,
               height: collectionView.frame.width / 3.02)
    }
}

// MARK: - UISearchResultsUpdating

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) { //обновляем поисковую строку и передаем вниз
        guard let text = searchController.searchBar.text else { return }
        filterContentForSearchText(text)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        for (value, hero) in heroesArray.enumerated() { //достучались-перебрали героев и присвоили значение-индекс
            let indexPath: IndexPath = [0, value]
            let cell = collectionView.cellForItem(at: indexPath)
            if hero.name.lowercased().contains(searchText.lowercased()) {   //проверка героя в итерации
                filtredArray.append(indexPath) //пишем букву - определились герои из индекспафа - сохранились в массив
                cell?.alpha = 1
            } else {
                cell?.alpha = 0.3
            }
        }

    }
}

//MARK: - UISearchControllerDelegate

extension MainViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) { //активация щелчком на контроллер
        isFiltred = true //жмякнули по серчу
        setAlphaForCell(alpha: 0.3) //прозрачность 30 процентов
    }
    
    func didDismissSearchController(_ searchController: UISearchController) { //прекращение с ним работать
        isFiltred = false
        setAlphaForCell(alpha: 1) // прозрачность 100 процентов
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
