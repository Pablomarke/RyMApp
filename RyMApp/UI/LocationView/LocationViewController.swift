//
//  LocationViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 13/8/23.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet weak var locationTable: UITableView!
    @IBOutlet weak var locationTabBar: UITabBar!
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var pagesView: UIView!
    @IBOutlet weak var pageLabel: UILabel!
    
    var model: AllLocations
    
    init(_ model: AllLocations) {
        self.model = model
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var pageCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor(named: "rickHair")
        navigationItem.title = "Localizaciones"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "rickHair")]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        
        self.view.backgroundColor = UIColor(named: "dark")
        
        backImage.image = UIImage(named: "w8")
        
        locationTabBar.delegate = self
        locationTabBar.isTranslucent = false
        locationTabBar.barTintColor = UIColor(named: "dark")
        
        locationTable.dataSource = self
        locationTable.delegate = self
        locationTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TBC")
        locationTable.backgroundColor = .clear
        
        pagesView.backgroundColor = .clear
        pageLabel.text = "\(pageCount) / \(model.info.pages)"
        pageLabel.textColor = UIColor(named: "rickHair")
        pageLabel.font = UIFont(name: "Get Schwifty Regular", size: 24)
        if model.info.prev == nil {
            backButton.isHidden = true
        }
    }
    
    @IBAction func nextBAct(_ sender: Any) {
        NetworkApi.shared.pagesLocation(url: (model.info.next)!) { AllLocations in
            
            self.model = AllLocations
            self.locationTable.reloadData()
            self.pageCount += 1
            self.pageLabel.text = "\(self.pageCount) / \(self.model.info.pages )"
            self.backButton.isHidden = false
            if self.model.info.next == nil {
                self.nextButton.isHidden = true
            }
        } failure: { error in
            print("Error")
        }
    }
    
    @IBAction func backBAct(_ sender: Any) {
        NetworkApi.shared.pagesLocation(url: (model.info.prev)!) { AllLocations in
            
            self.model = AllLocations
            self.locationTable.reloadData()
            self.pageCount -= 1
            self.pageLabel.text = "\(self.pageCount) / \(self.model.info.pages )"
            self.nextButton.isHidden = false
            if self.model.info.prev == nil {
                
                self.backButton.isHidden = true
            }
        } failure: { error in
            print("Error")
        }
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
            self.navigationController?.show(detail,
                                            sender: nil)
        } failure: { error in
            print("Error")
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

