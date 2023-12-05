//
//  SearchViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 8/8/23.
//

import UIKit

class SearchViewController: UIViewController {
    //MARK: - IBOutlets -
    @IBOutlet weak var tabBarSearch: UITabBar!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchCollection: UICollectionView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var buttonView: UIView!
    
    // MARK: - Propiedades -
    var model: AllCharacters
    
    // MARK: - Init -
    init(_ model: AllCharacters) {
        self.model = model
        
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Ciclo de vida -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = Color.mainColor
        self.view.backgroundColor = Color.mainColor
        
        //Title
        self.navigationController?.navigationBar.tintColor = Color.secondColor
        navigationItem.title = "Buscador"
        let textAttributes = [NSAttributedString.Key.foregroundColor: Color.secondColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        
        //SearchText
        searchText.placeholder = "Introduce nombre"
        searchText.layer.cornerRadius = 40
        searchText.backgroundColor = Color.secondColor
        
        backImage.image = LocalImages.searchImage
        backImage.contentMode = .scaleAspectFill
        
        ///Button
        buttonView.backgroundColor = Color.secondColor
        buttonView.layer.cornerRadius = 24
        searchButton.titleLabel?.text = "Buscar"
        searchButton.tintColor = .black
        
        ///Tab bar
        tabBarSearch.delegate = self
        tabBarSearch.tintColor = Color.secondColor
        tabBarSearch.barTintColor = Color.mainColor
        tabBarSearch.isTranslucent = false

        ///Search Collection
        searchCollection.clearBackground()
        searchCollection.dataSource = self
        searchCollection.delegate = self
        searchCollection.register(UINib(nibName: CharacterCell.identifier,
                                        bundle: nil),
                                      forCellWithReuseIdentifier: CharacterCell.identifier)
        searchCollection.isHidden = true
    }
    
    // MARK: - Botones -
    @IBAction func searchAction(_ sender: Any) {
        let newName = searchText.text
        NetworkApi.shared.searchCharacters(name: newName!) { allCharacters in
            self.model = allCharacters
            self.searchCollection.reloadData()
            self.searchText.backgroundColor = Color.secondColor
            self.searchCollection.isHidden = false
        }
    }
}

// MARK: - Extension de datasource -
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return model.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier,
                                                              for: indexPath) as? CharacterCell else {
            return UICollectionViewCell()
        }
        
        if let modelForCell = model.results?[indexPath.row] {
            cell.syncCellWithModel(model: modelForCell)
        }
            
        return cell
    }
}

// MARK: - Extension de delegado -
extension SearchViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if let myID = model.results?[indexPath.row].id {
            NetworkApi.shared.getCharacter(id: myID ) { character in
                let detailedView = DetailViewController(model: character)
                self.navigationController?.showDetailViewController(detailedView,
                                                                    sender: nil)
            }
        }
    }
}

extension SearchViewController: UITabBarDelegate {
    func tabBar(
        _ tabBar: UITabBar,
        didSelect item: UITabBarItem
    ) {
        switch item.title {
            case "Characters" :
            NetworkApi.shared.getAllCharacters { allCharacters in
                let myView = CharactersViewController(allCharacters)
                self.navigationController?.setViewControllers([myView],
                                                              animated: true)
            }
            case "Search" :
                break
                
            case "Episodes" :
            NetworkApi.shared.getArrayEpisodes(season: "1,2,3,4,5,6,7,8,9,10,11") { episodes in
                let myView = EpisodesViewController(episodes)
                self.navigationController?.setViewControllers([myView],
                                                              animated: true)
            }
            case "Locations" :
            NetworkApi.shared.getAllLocations() { locations in
                let myView = LocationViewController( locations)
                self.navigationController?.setViewControllers([myView],
                                                              animated: true)
            }
            case .none:
                break
            case .some(_):
                break
        }
    }
}
