//
//  SearchViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 8/8/23.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var tabBarSearch: UITabBar!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchCollection: UICollectionView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var model: AllCharacters
    
    init(_ model: AllCharacters) {
        self.model = model
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "dark")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "rickHair")
        
        titleLabel.text = "Buscador de personajes"
        titleLabel.font = UIFont(name: "Get Schwifty Regular", size: 24)
        titleLabel.textColor = UIColor(named: "rickHair")
        searchButton.titleLabel?.text = "Buscar"
        searchText.placeholder = "Introduce nombre"
        searchText.layer.cornerRadius = 20
        searchText.backgroundColor = UIColor(named: "rickHair")
        
        backImage.image = UIImage(named: "r3")
        backImage.contentMode = .scaleAspectFill
        self.view.backgroundColor = .clear
        
        tabBarSearch.delegate = self
        tabBarSearch.tintColor = UIColor(named: "rickHair")
        tabBarSearch.barTintColor = UIColor(named: "dark")
        tabBarSearch.isTranslucent = false

        searchCollection.backgroundColor = UIColor.clear
        searchCollection.backgroundView = UIView.init(frame: CGRect.zero)
        
        searchCollection.dataSource = self
        searchCollection.delegate = self
        searchCollection.register(UINib(nibName: "CharacterCell", bundle: nil),
                                      forCellWithReuseIdentifier: "CellC")
        
        searchCollection.isHidden = true
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
        self.searchCollection.isHidden = false
        let newName = searchText.text
        NetworkApi.shared.searchCharacters(name: newName!) { allCharacters in
            self.model = allCharacters
            self.searchCollection.reloadData()
        } failure: { error in
            self.searchText.backgroundColor = .red
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
        if cell.characterStatus.text == "Alive" {
            cell.statusView.backgroundColor = .green
        } else if cell.characterStatus.text == "Dead"{
            cell.statusView.backgroundColor = .red
        } else {
            cell.statusView.backgroundColor = .gray
            cell.statusView.layer.cornerRadius = 6
            cell.characterStatus.textColor = .black
        }
        return cell
    }
}
extension SearchViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "Characters"{
            NetworkApi.shared.getAllCharacters { allCharacters in
                var myView = CharactersViewController(allCharacters)
                self.navigationController?.pushViewController(myView,
                                                              animated: true)
            } failure: { error in
                self.titleLabel.text = "Error"
            }
        } else if item.title == "Search" {
            NetworkApi.shared.getAllCharacters { allCharacters in
                var myView = SearchViewController(allCharacters)
                self.navigationController?.pushViewController(myView,
                                                              animated: true)
            } failure: { error in
                self.titleLabel.text = "Error"
            }
        } else if item.title == "Episodes" {
            NetworkApi.shared.getAllEpisodes { episodes in
               var myView = EpisodesViewController(episodes)
                self.navigationController?.pushViewController(myView,
                                                              animated: true)
            } failure: { error in
                self.titleLabel.text = "Error"
            }
        } else if item.title == "Locations" {
            NetworkApi.shared.getAllLocations() { locations in
                var myView = LocationViewController(locations)
                self.navigationController?.pushViewController(myView,
                                                              animated: true)
            } failure: { error in
                self.titleLabel.text = "Error"
            }
        }
       
    }
}
