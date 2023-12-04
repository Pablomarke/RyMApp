//
//  HomeViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 27/7/23.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: - IBOutlets -
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var buttonImage: UIView!
    
    // MARK: - Ciclo de vida -
    override func viewDidLoad() {
        super.viewDidLoad()
        backImage.image = UIImage(
            named: "w1"
        )
        backImage.contentMode = .scaleToFill
        buttonLabel.text = "Entrar"
        buttonLabel.font = UIFont(
            name: "Get Schwifty Regular",
            size: 32
        )
        buttonLabel.textAlignment = .center
        homeButton.tintColor = .clear
        buttonImage.backgroundColor = UIColor(
            named: "rickHair"
        )
        buttonImage.layer.cornerRadius = 60
    }
    
    // MARK: - Botones -
    @IBAction func homeBAction(
        _ sender: Any
    ) {
        NetworkApi.shared.getAllCharacters { allCharacters in
            let viewController = CharactersViewController(
                allCharacters
            )
            self.navigationController?.setViewControllers(
                [viewController],
                animated: true
            )
        }
    }
}


