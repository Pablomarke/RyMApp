//
//  TableViewCell.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 9/8/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var dataView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        contentView.backgroundColor = UIColor(named: "myClear")

        titleView.layer.cornerRadius = 12
        titleView.backgroundColor = UIColor(named: "rickHair")
        
        dataView.layer.cornerRadius = 12
        dataView.backgroundColor = UIColor(named: "rickHair")
        
        titleLabel.textColor = .black
        dataLabel.textColor = UIColor(named: "dark")
        self.backgroundColor = UIColor.clear
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
