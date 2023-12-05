//
//  CharacterCell.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 4/8/23.
//

import UIKit
import Kingfisher

class CharacterCell: UICollectionViewCell {
    //MARK: - IBOutlets -
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var CharacterView: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var characterStatus: UILabel!
    
    // MARK: - Propiedades -
    
    static let identifier: String = "CharacterCell"
    
    // MARK: - Funciones -
    override func awakeFromNib() {
        super.awakeFromNib()
        cellStyle()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterName.text = nil
        characterStatus.text = nil
        statusView.backgroundColor = nil
    }
    
    // MARK: - Funciones -
    func cellStyle(){
        backView.backgroundColor = color.mainColor
        characterName.numberOfLines = 2
        characterName.textColor = .white
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
