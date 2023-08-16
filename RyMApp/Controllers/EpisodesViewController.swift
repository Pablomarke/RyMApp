//
//  EpisodesViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 11/8/23.
//

import UIKit

class EpisodesViewController: UIViewController {
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var episodeTable: UITableView!
    @IBOutlet weak var tabBarEpisode: UITabBar!
    
    var model: AllEpisodes
    
    init(_ model: AllEpisodes) {
        self.model = model
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor(named: "rickHair")
        navigationItem.title = "Episodios"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "rickHair")]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        
        self.view.backgroundColor = UIColor(named: "dark")
        tabBarEpisode.barTintColor = UIColor(named: "dark")
        tabBarEpisode.isTranslucent = false
        tabBarEpisode.tintColor = UIColor(named: "rickHair")
        
        episodeTable.dataSource = self
        episodeTable.delegate = self
        episodeTable.register(UINib(nibName: "TableViewCell",
                                    bundle: nil), forCellReuseIdentifier: "TC")
        episodeTable.backgroundColor = .clear
        tabBarEpisode.delegate = self
    }
}

extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return model.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = episodeTable.dequeueReusableCell(withIdentifier: "TC") as! TableViewCell?
        cell?.titleLabel.text = model.results?[indexPath.row].episode
        cell?.dataLabel.text = model.results?[indexPath.row].name
        cell?.titleLabel.textColor = .black
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NetworkApi.shared.getEpisode(url: (model.results?[indexPath.row].url)!) { episode in
            let detail = EpisodeDetailViewController(episode)
            self.navigationController?.pushViewController(detail,
                                                          animated: true)
        } failure: { error in
            print("Error")
        }
        
    }
}

extension EpisodesViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "Characters" {
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
            NetworkApi.shared.getAllEpisodes { episodes in
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
