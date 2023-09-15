//
//  SearchViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 8/8/23.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {
    // Outlets
    @IBOutlet weak var tabBarSearch: UITabBar!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchCollection: UICollectionView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var buttonView: UIView!
    
  
    //Modelo
    var model: AllCharacters
    
    init(_ model: AllCharacters) {
        self.model = model
        
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "dark")
        self.view.backgroundColor = UIColor(named: "dark")
        
        ///Title
        self.navigationController?.navigationBar.tintColor = UIColor(named: "rickHair")
        navigationItem.title = "Buscador"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "rickHair")]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        
        ///SearchText
        searchText.placeholder = "Introduce nombre"
        searchText.layer.cornerRadius = 40
        searchText.backgroundColor = UIColor(named: "rickHair")
        
        backImage.image = UIImage(named: "r3")
        backImage.contentMode = .scaleAspectFill
        
        ///Button
        buttonView.backgroundColor = UIColor(named: "rickHair")
        buttonView.layer.cornerRadius = 24
        searchButton.titleLabel?.text = "Buscar"
        searchButton.tintColor = .black
        
        ///Tab bar
        tabBarSearch.delegate = self
        tabBarSearch.tintColor = UIColor(named: "rickHair")
        tabBarSearch.barTintColor = UIColor(named: "dark")
        tabBarSearch.isTranslucent = false

        ///Search Collection
        searchCollection.backgroundColor = UIColor.clear
        searchCollection.backgroundView = UIView.init(frame: CGRect.zero)
        searchCollection.dataSource = self
        searchCollection.delegate = self
        searchCollection.register(UINib(nibName: "CharacterCell",
                                        bundle: nil),
                                      forCellWithReuseIdentifier: "CellC")
        searchCollection.isHidden = true
    }
    
    //Button search
    @IBAction func searchAction(_ sender: Any) {
        let newName = searchText.text
        NetworkApi.shared.searchCharacters(name: newName!) { allCharacters in
            self.model = allCharacters
            self.searchCollection.reloadData()
            self.searchText.backgroundColor = UIColor(named: "rickHair")
            self.searchCollection.isHidden = false
        } failure: { error in
            self.searchText.backgroundColor = .red
            self.searchCollection.isHidden = true
            self.searchText.text = "No hay resultados"
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return model.results!.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: "CellC",
                                                            for: indexPath) as! CharacterCell
        let urlImage = URL(string: model.results![indexPath.row].image)
        cell.CharacterView.kf.setImage(with: urlImage)
        cell.characterName.text = model.results![indexPath.row].name
        cell.characterStatus.text = model.results![indexPath.row].status
        cell.statusView.backgroundColor = model.results![indexPath.row].statusColor()
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        NetworkApi.shared.getCharacter(id: model.results![indexPath.row].id) { character in
            let detailedView = DetailViewController(model: character)
            self.navigationController?.showDetailViewController(detailedView,
                                                                sender: nil)
        } failure: { error in
            print("Error")
        }
    }
}

extension SearchViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "Characters"{
            NetworkApi.shared.getAllCharacters { allCharacters in
                let myView = CharactersViewController(allCharacters)
                self.navigationController?.pushViewController(myView,
                                                              animated: true)
            } failure: { error in
                print("Error")
            }
        } else if item.title == "Search" {
            NetworkApi.shared.getAllCharacters { allCharacters in
                let myView = SearchViewController(allCharacters)
                self.navigationController?.pushViewController(myView,
                                                              animated: true)
            } failure: { error in
                print("Error")
            }
        } else if item.title == "Episodes" {
            NetworkApi.shared.getArrayEpisodes(season: "1,2,3,4,5,6,7,8,9,10,11") { episodes in
                let myView = EpisodesViewController(episodes)
                self.navigationController?.pushViewController(myView,
                                                              animated: true)
            } failure: { error in
                print("Error")
            }
        } else if item.title == "Locations" {
            NetworkApi.shared.getAllLocations() { locations in
                let myView = LocationViewController(locations)
                self.navigationController?.pushViewController(myView,
                                                              animated: true)
            } failure: { error in
                print("Error")
            }
        }
    }
}
