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
        
        NetworkApi.shared.getAllCharacters { allCharacters in
            let allCharacters = CharactersViewController(allCharacters)
                self.navigationController?.pushViewController(allCharacters, animated: true)
        } failure: { error in
            self.homeLabel.text = "Error"
        }

        
        
       
    }
}
