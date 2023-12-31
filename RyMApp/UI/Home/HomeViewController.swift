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
        viewStyle()
        buttonStyle()
    }
    
    // MARK: - Funciones -
    func viewStyle(){
        backImage.image = LocalImages.homeImage
        backImage.contentMode = .scaleToFill
    }
    
    func buttonStyle(){
        buttonLabel.text = "Enter"
        buttonLabel.font = Font.size32
        buttonLabel.textAlignment = .center
        homeButton.tintColor = .clear
        buttonImage.backgroundColor = Color.secondColor
        buttonImage.layer.cornerRadius = 60
    }
    
    func navigateToCharacters(){
        NetworkApi.shared.getAllCharacters { allCharacters in
            let viewController = CharactersViewController(allCharacters)
            self.navigationController?.setViewControllers([viewController],
                                                          animated: true)
        }
    }
    
    // MARK: - Botones -
    @IBAction func homeBAction(_ sender: Any) {
        navigateToCharacters()
    }
}


