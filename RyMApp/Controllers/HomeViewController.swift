//
//  HomeViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 27/7/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        backImage.image = UIImage(named: "w1")
        backImage.contentMode = .scaleToFill
        
        buttonLabel.text = "Entrar"
        buttonLabel.font = UIFont(name: "Get Schwifty Regular", size: 32)
        buttonLabel.textAlignment = .center
        homeButton.tintColor = UIColor(named: "rickHair")
        
        
    }
    
    @IBAction func homeBAction(_ sender: Any) {
        
        NetworkApi.shared.getAllCharacters { allCharacters in
            let allCharacters = CharactersViewController(allCharacters)
            self.navigationController?.pushViewController(allCharacters, animated: true)
        } failure: { error in
            print("Error")
        }
    }
}
