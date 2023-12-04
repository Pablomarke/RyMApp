//
//  CharacterCell.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 4/8/23.
//

import UIKit
import Kingfisher

class CharacterCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var CharacterView: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var characterStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.backgroundColor = UIColor(named: "dark")
        characterName.numberOfLines = 2
        characterName.textColor = .white
        backView.layer.cornerRadius = 16
        backView.layer.cornerRadius = 16
        characterStatus.textColor = .black
        CharacterView.layer.cornerRadius = 40
        statusView.layer.cornerRadius = 8
    }
    
    func syncCellWithModel(model: Character) {
        characterName.text = model.name
        let urlImage = URL(string: model.image)
        CharacterView.kf.setImage(with: urlImage)
        characterStatus.text = model.status
        statusView.backgroundColor = model.statusColor()
    }
}
