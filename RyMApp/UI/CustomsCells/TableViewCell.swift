//
//  TableViewCell.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 9/8/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    //MARK: - IBOutlets -
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var dataView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellStyle()
        
    }
    // MARK: - Funciones -
    func cellStyle(){
        contentView.backgroundColor = color.clearColor
        titleLabel.textColor = .black
        dataLabel.textColor = color.mainColor
        self.backgroundColor = UIColor.clear
        
        titleView.corner12()
        dataView.corner12()
        
        
    }
    
    func syncEpisodeWithCell(model: Episode) {
        titleLabel.text = model.episode
        dataLabel.text = model.name
    }
    
    func syncLocationWithCell(model: Location){
        titleLabel.text = model.type
        dataLabel.text = model.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        dataLabel.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // TODO
    }
}


