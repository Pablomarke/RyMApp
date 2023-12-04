//
//  CharactersViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 28/7/23.
//

import UIKit

class CharactersViewController: UIViewController {
    //MARK: - IBOutlets -
    @IBOutlet weak var characterBar: UITabBar!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var collectionCharacters: UICollectionView!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var pagesLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - Propiedades -
    var model: AllCharacters
    var countPage = 1
    
    // MARK: - Init -
    init(
        _ model: AllCharacters
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
        self.view.backgroundColor = UIColor(named: "dark")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "rickHair")
        navigationItem.title = "Personajes"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(
            named: "rickHair"
        )]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        
        if model.info?.prev == nil || model.info?.next == nil {
            backButton.isHidden = true
        }
        
        backImage.image = UIImage(
            named: "w2"
        )
        backImage.contentMode = .scaleToFill
        
        collectionCharacters.backgroundColor = UIColor.clear
        collectionCharacters.backgroundView = UIView.init(
            frame: CGRect.zero
        )
        collectionCharacters.dataSource = self
        collectionCharacters.delegate = self
        collectionCharacters.register(
            UINib(
                nibName: "CharacterCell",
                bundle: nil
            ),
            forCellWithReuseIdentifier: "CellC"
        )
        
        characterBar.delegate = self
        characterBar.tintColor = UIColor(
            named: "rickHair"
        )
        characterBar.barTintColor = UIColor(
            named: "dark"
        )
        characterBar.isTranslucent = false
        
        pageView.backgroundColor = .clear
        pagesLabel.text = "\(countPage) / \(model.info?.pages ?? 1)"
        pagesLabel.textColor = UIColor(
            named: "rickHair"
        )
        pagesLabel.font = UIFont(
            name: "Get Schwifty Regular",
            size: 24
        )
    }
    
    // MARK: - Funciones -
    
    // MARK: - Botones -
    @IBAction func nextButtonAction(
        _ sender: Any
    ) {
        NetworkApi.shared.pages(url: (model.info?.next)!) { allCharacters in
            self.model = allCharacters
            self.collectionCharacters.reloadData()
            self.countPage += 1
            self.pagesLabel.text = "\(self.countPage) / \(self.model.info?.pages ?? 1)"
            self.backButton.isHidden = false
            if self.model.info?.next == nil {
                self.nextButton.isHidden = true
            }
            self.collectionCharacters.reloadData()
        }
    }
    
    @IBAction func backButtonAction(
        _ sender: Any
    ) {
        NetworkApi.shared.pages(url: (model.info?.prev)!) { allCharacters in
            self.model = allCharacters
            self.countPage -= 1
            self.pagesLabel.text = "\(self.countPage) / \(self.model.info?.pages ?? 1)"
            self.nextButton.isHidden = false
            if self.model.info?.prev == nil {
                self.backButton.isHidden = true
            }
            self.collectionCharacters.reloadData()
        }
    }
}

// MARK: - Extension de datasource -
extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return model.results!.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionCharacters.dequeueReusableCell(
            withReuseIdentifier: "CellC",
            for: indexPath
        ) as! CharacterCell
        cell.syncCellWithModel(model: model.results![indexPath.row])
        return cell
    }
}

// MARK: - Extension de delegado -
extension CharactersViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        NetworkApi.shared.getCharacter(
            id: model.results![indexPath.row].id
        ) { character in
            let detailedView = DetailViewController(
                model: character
            )
            self.navigationController?.show(
                detailedView,
                sender: nil
            )
        }
    }
}

// MARK: - Extension de tabBar -
extension CharactersViewController: UITabBarDelegate {
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
