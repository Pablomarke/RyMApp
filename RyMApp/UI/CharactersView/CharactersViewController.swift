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
        viewStyle()
        collectionStyle()
        pagesStyle()
        characterBarStyle()
    }
    
    // MARK: - Funciones -
    func viewStyle(){
        backImage.image = LocalImages.charactersImage
        backImage.contentMode = .scaleToFill
        self.view.backgroundColor = Color.mainColor
        self.navigationController?.navigationBar.tintColor = Color.secondColor
        navigationItem.title = "Characters"
        let textAttributes = [NSAttributedString.Key.foregroundColor: Color.secondColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
    }
    
    func collectionStyle(){
        collectionCharacters.clearBackground()
        collectionCharacters.dataSource = self
        collectionCharacters.delegate = self
        collectionCharacters.register(
            UINib( nibName: CharacterCell.identifier,
                   bundle: nil),
            forCellWithReuseIdentifier: CharacterCell.identifier)
    }
    
    func pagesStyle(){
        pageView.backgroundColor = .clear
        pagesLabel.text = "\(countPage) / \(model.info?.pages  ?? 1)"
        pagesLabel.textColor = Color.secondColor
        pagesLabel.font = Font.size24
        
        if model.info?.prev == nil || model.info?.next == nil {
            backButton.isHidden = true
        }
    }
    
    func characterBarStyle(){
        characterBar.delegate = self
        characterBar.tintColor = Color.secondColor
        characterBar.barTintColor = Color.mainColor
        characterBar.isTranslucent = false
    }
    
    func nextPage(){
        NetworkApi.shared.pages(url: (model.info?.next ?? "")) { allCharacters in
            self.model = allCharacters
            self.countPage += 1
            self.showBackButton()
            self.collectionCharacters.reloadData()
        }
    }
    
    func prevPage(){
        NetworkApi.shared.pages(url: (model.info?.prev ?? "")) { allCharacters in
            self.model = allCharacters
            self.countPage -= 1
            self.showPrevButton()
            self.collectionCharacters.reloadData()
        }
    }
    
    func showBackButton(){
        self.pagesLabel.text = "\(self.countPage) / \(self.model.info?.pages ?? 1)"
        self.backButton.isHidden = false
        if self.model.info?.next == nil {
            self.nextButton.isHidden = true
        }
    }
    
    func showPrevButton(){
        self.pagesLabel.text = "\(self.countPage) / \(self.model.info?.pages ?? 1)"
        self.nextButton.isHidden = false
        if self.model.info?.prev == nil {
            self.backButton.isHidden = true
        }
    }
    
    // MARK: - Botones -
    @IBAction func nextButtonAction(_ sender: Any) {
        nextPage()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        prevPage()
    }
}

    // MARK: - Extension de datasource -
extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return model.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionCharacters.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier,
                                                                  for: indexPath) as? CharacterCell else {
            return UICollectionViewCell()
        }
        
        if let cellModel = model.results?[indexPath.row] {
            cell.syncCellWithModel(model: cellModel)
        } 
        return cell
    }
}

    // MARK: - Extension de delegado -
extension CharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        NetworkApi.shared.getCharacter(id: model.results?[indexPath.row].id ?? 1) { character in
            let detailedView = DetailViewController(
                model: character)
            self.navigationController?.show(detailedView,
                                            sender: nil)
        }
    }
}

    // MARK: - Extension de tabBar -
extension CharactersViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar,
                didSelect item: UITabBarItem) {
        switch item.title {
            case "Characters" :
                break
            
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
