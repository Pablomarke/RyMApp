//
//  DetailViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 27/7/23.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageDetail: UIImageView!
    
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
   
    var model: Character
    
    init(model: Character) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        syncModel()
    }
    
    func syncModel() {
        nameLabel.text = model.name
        speciesLabel.text = model.species
        typeLabel.text = model.type
        genderLabel.text = model.gender
        createdLabel.text = dateToString(date: model.created)
        let imageUrl = model.image
        imageDetail.kf.setImage(with: URL(string: imageUrl))
    }
    
    func dateToString(date: Date) -> String {
        let myDate = DateFormatter()
        myDate.dateStyle = .short
        let newDate = myDate.string(from: date)
        return newDate
    }
}
