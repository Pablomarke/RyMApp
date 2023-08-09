//
//  TableViewCell.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 9/8/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var dataView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 12
        titleView.layer.cornerRadius = 12
        dataView.layer.cornerRadius = 12
        
        backView.backgroundColor = UIColor(named: "dark")
        titleView.backgroundColor = UIColor(named: "dark")
        dataView.backgroundColor = .clear
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
