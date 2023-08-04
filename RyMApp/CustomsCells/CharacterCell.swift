//
//  CharacterCell.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 4/8/23.
//

import UIKit

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
        CharacterView.layer.cornerRadius = 40
        
        statusView.layer.cornerRadius = 8
    }

}
