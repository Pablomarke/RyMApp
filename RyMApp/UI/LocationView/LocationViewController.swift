//
//  LocationViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 13/8/23.
//

import UIKit

class LocationViewController: UIViewController {
    //MARK: - IBOutlets -
    @IBOutlet weak var locationTable: UITableView!
    @IBOutlet weak var locationTabBar: UITabBar!
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var pagesView: UIView!
    @IBOutlet weak var pageLabel: UILabel!
    
    // MARK: - Propiedades -
    var model: AllLocations
    var pageCount = 1
    
    // MARK: - Init -
    init(
        _ model: AllLocations
    ) {
        self.model = model
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError(
            "init(coder:) has not been implemented"
        )
    }
    
    // MARK: - Ciclo de vida -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = color.mainColor
        navigationItem.title = "Localizaciones"
        let textAttributes = [NSAttributedString.Key.foregroundColor: color.secondColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        
        self.view.backgroundColor = color.mainColor
        
        backImage.image = UIImage(
            named: "w8"
        )
        
        locationTabBar.delegate = self
        locationTabBar.isTranslucent = false
        locationTabBar.barTintColor = color.mainColor
        
        locationTable.dataSource = self
        locationTable.delegate = self
        locationTable.register(
            UINib(
                nibName: "TableViewCell",
                bundle: nil
            ),
            forCellReuseIdentifier: "TBC"
        )
        locationTable.backgroundColor = .clear
        
        pagesView.backgroundColor = .clear
        pageLabel.text = "\(pageCount) / \(model.info.pages)"
        pageLabel.textColor = color.secondColor
        pageLabel.font = font.size24
        if model.info.prev == nil {
            backButton.isHidden = true
        }
    }
    
    // MARK: - Botones -
    @IBAction func nextBAct(
        _ sender: Any
    ) {
        NetworkApi.shared.pagesLocation(
            url: (
                model.info.next
            )!
        ) { AllLocations in
            
            self.model = AllLocations
            self.locationTable.reloadData()
            self.pageCount += 1
            self.pageLabel.text = "\(self.pageCount) / \(self.model.info.pages )"
            self.backButton.isHidden = false
            if self.model.info.next == nil {
                self.nextButton.isHidden = true
            }
        }
    }
    
    @IBAction func backBAct(
        _ sender: Any
    ) {
        NetworkApi.shared.pagesLocation(
            url: (
                model.info.prev
            )!
        ) { AllLocations in
            
            self.model = AllLocations
            self.locationTable.reloadData()
            self.pageCount -= 1
            self.pageLabel.text = "\(self.pageCount) / \(self.model.info.pages )"
            self.nextButton.isHidden = false
            if self.model.info.prev == nil {
                
                self.backButton.isHidden = true
            }
        }
    }
}

// MARK: - Extension de datasource -
extension LocationViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return model.results.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "TBC"
        ) as! TableViewCell
        cell.titleLabel.text = model.results[indexPath.row].type
        cell.dataLabel.text =  model.results[indexPath.row].name
        return cell
    }
}

// MARK: - Extension de delegado -
extension LocationViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        NetworkApi.shared.getLocationUrl(url: (model.results[indexPath.row].url)) { locations in
         let detail = LocationDetailViewController(locations)
         self.navigationController?.show(detail,
         sender: nil)
         }
    }
}

extension LocationViewController: UITabBarDelegate {
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
            NetworkApi.shared.getAllCharacters { allCharacters in
                let myView = SearchViewController(allCharacters)
                self.navigationController?.setViewControllers([myView],
                                                              animated: true)
            }
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

