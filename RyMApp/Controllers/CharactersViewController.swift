//
//  CharactersViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 28/7/23.
//

import UIKit
import Kingfisher

class CharactersViewController: UIViewController {

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var collectionCharacters: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var model: AllCharacters
    
    init(_ model: AllCharacters) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Personajes principales"
        titleLabel.textColor = UIColor(named: "rickHair")
        titleLabel.font = UIFont(name: "Get Schwifty Regular", size: 24)
        
        
        backImage.image = UIImage(named: "w2")
        backImage.contentMode = .scaleToFill
        
        
        collectionCharacters.backgroundColor = UIColor.clear
        collectionCharacters.backgroundView = UIView.init(frame: CGRect.zero)
        
        collectionCharacters.dataSource = self
        collectionCharacters.delegate = self
        collectionCharacters.register(UINib(nibName: "CharacterViewCell", bundle: nil),
                                      forCellWithReuseIdentifier: "CellC")

    }

    func syncModel(){
        
    }
}

extension CharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        NetworkApi.shared.getCharacter(id: model.results![indexPath.row].id) { character in
            let detailedView = DetailViewController(model: character)
            self.navigationController?.pushViewController(detailedView,
                                                          animated: true)
            
        } failure: { error in
            self.titleLabel.text = "Error"
        }
    }
    
    
}

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.results!.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionCharacters.dequeueReusableCell(withReuseIdentifier: "CellC", for: indexPath) as! CharacterViewCell
        
        cell.nameCharacter.text = model.results![indexPath.row].name
        let urlImage = URL(string: model.results![indexPath.row].image)
        cell.imageCharacter.kf.setImage(with: urlImage)
        
        
        return cell
    }
}
