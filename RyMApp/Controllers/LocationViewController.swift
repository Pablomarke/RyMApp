//
//  LocationViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 13/8/23.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationTable: UITableView!
    @IBOutlet weak var locationTabBar: UITabBar!
    @IBOutlet weak var backImage: UIImageView!
    
    var model: AllLocations
    
    init(_ model: AllLocations) {
        self.model = model
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Localizaciones"
        titleLabel.textColor = UIColor(named: "rickHair")
        titleLabel.font = UIFont(name: "Get Schwifty Regular", size: 24)
        self.view.backgroundColor = UIColor(named: "dark")
        
        backImage.image = UIImage(named: "w8")
        
        locationTabBar.delegate = self
        locationTabBar.isTranslucent = false
        locationTabBar.barTintColor = UIColor(named: "dark")
        
        locationTable.dataSource = self
        locationTable.delegate = self
        locationTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TBC")
        locationTable.backgroundColor = .clear
        
    }
}

extension LocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return model.results.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TBC") as! TableViewCell
        cell.titleLabel.text = model.results[indexPath.row].type
        cell.dataLabel.text =  model.results[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        NetworkApi.shared.getLocationUrl(url: (model.results[indexPath.row].url)) { locations in
            let detail = LocationDetailViewController(locations)
            self.navigationController?.pushViewController(detail,
                                                          animated: true)
        } failure: { error in
            self.titleLabel.text = "Error"
        }
        
    }
}
extension LocationViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "Characters" {
            NetworkApi.shared.getAllCharacters { allCharacters in
                let myView = CharactersViewController(allCharacters)
                self.navigationController?.pushViewController(myView,
                                                              animated: true)
            } failure: { error in
                self.titleLabel.text = "Error"
            }
        } else if item.title == "Search" {
            NetworkApi.shared.getAllCharacters { allCharacters in
                let myView = SearchViewController(allCharacters)
                self.navigationController?.pushViewController(myView,
                                                              animated: true)
            } failure: { error in
                self.titleLabel.text = "Error"
            }
        } else if item.title == "Episodes" {
            NetworkApi.shared.getAllEpisodes { episodes in
                let myView = EpisodesViewController(episodes)
                self.navigationController?.pushViewController(myView,
                                                              animated: true)
            } failure: { error in
                self.titleLabel.text = "Error"
            }
        } else if item.title == "Locations" {
            NetworkApi.shared.getAllLocations() { locations in
                let myView = LocationViewController(locations)
                self.navigationController?.pushViewController(myView,
                                                              animated: true)
            } failure: { error in
                self.titleLabel.text = "Error"
            }
        }
       
    }
}

