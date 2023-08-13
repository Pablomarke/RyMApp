//
//  EpisodeDetailViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 12/8/23.
//

import UIKit
import Kingfisher

class EpisodeDetailViewController: UIViewController {
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var estrenoLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var collectionCharacters: UICollectionView!
    
    var model: Episode
    
    init(_ model: Episode) {
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
        topView.backgroundColor = .clear
        characterLabel.text = "Personajes"
        backImage.image = UIImage(named: "r1")
        backImage.contentMode =  .scaleToFill
        topView.backgroundColor = .clear
        nameLabel.text = model.name
        nameLabel.font = UIFont(name: "Get Schwifty Regular",
                                size: 24)
        nameLabel.textColor = UIColor(named: "rickHair")
        nameLabel.numberOfLines = 2
        episodeLabel.text = model.episode
        estrenoLabel.text = "" //por hacer
        
        collectionCharacters.dataSource = self
        collectionCharacters.delegate = self
        collectionCharacters.backgroundColor = .clear
        collectionCharacters.register(UINib(nibName: "CharacterCell", bundle: nil),
                                      forCellWithReuseIdentifier: "CC")

    }

}

extension EpisodeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionCharacters.dequeueReusableCell(withReuseIdentifier: "CC", for: indexPath) as! CharacterCell
        NetworkApi.shared.getCharacterUrl(url: model.characters[indexPath.row]) { character in
            cell.characterName.text = character.name
            let urlImage = URL(string: character.image)
            cell.CharacterView.kf.setImage(with: urlImage)
            cell.characterStatus.text = character.status
            if cell.characterStatus.text == "Alive" {
                cell.statusView.backgroundColor = .green
            } else if cell.characterStatus.text == "Dead"{
                cell.statusView.backgroundColor = .red
            } else {
                cell.statusView.backgroundColor = .gray
                cell.statusView.layer.cornerRadius = 6
                cell.characterStatus.textColor = .black
            }
            
        } failure: { error in
            self.characterLabel.text = "Error"
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NetworkApi.shared.getCharacterUrl(url: model.characters[indexPath.row]) { character in
            let detailedView = DetailViewController(model: character)
            self.navigationController?.pushViewController(detailedView,
                                                          animated: true)
        } failure: { error in
            self.characterLabel.text = "Error"
        }
    }
}