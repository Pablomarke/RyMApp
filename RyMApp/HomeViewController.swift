//
//  HomeViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 27/7/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var homeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeLabel.text = "Hola Mundo"
        homeLabel.textColor = UIColor.red
    }
    
    @IBAction func homeBAction(_ sender: Any) {
        
        
        NetworkApi.shared.getCharacter(id: 8) { character in
            let detailedView = DetailViewController(model: character)
            self.navigationController?.pushViewController(detailedView, animated: true)
            self.homeLabel.text = character.name
        } failure: { error in
            self.homeLabel.text = error.debugDescription
        }

       
    
    }
}
