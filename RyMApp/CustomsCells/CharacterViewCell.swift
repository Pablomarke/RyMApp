//
//  CharacterViewCell.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 28/7/23.
//

import UIKit

class CharacterViewCell: UICollectionViewCell {

    @IBOutlet weak var nameCharacter: UILabel!
    @IBOutlet weak var imageCharacter: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageCharacter.contentMode = .scaleAspectFill
        
        nameCharacter.textColor = UIColor(named: "rickHair")
        nameCharacter.font = UIFont(name: "Get Schwifty Regular", size: 16)
        nameCharacter.backgroundColor = UIColor.secondaryLabel
        nameCharacter.shadowColor = UIColor.blue
        
    }
}
