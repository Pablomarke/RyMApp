//
//  DetailViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 27/7/23.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var colorCharacter: UIView!
    @IBOutlet weak var colorStatus: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var dataViewImportant: UIView!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var detailTable: UITableView!
    
    @IBOutlet weak var speciesView: UIView!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var genderView: UIView!
    
    @IBOutlet weak var locationView: UIView!
    
    @IBOutlet weak var originView: UIView!
    
    @IBOutlet weak var tSpeciesView: UIView!
    @IBOutlet weak var tSpeciesLabel: UILabel!
    
    @IBOutlet weak var tTypeView: UIView!
    @IBOutlet weak var tTypeLabel: UILabel!
    
    @IBOutlet weak var tGendeView: UIView!
    @IBOutlet weak var tGenderLabel: UILabel!
    
    @IBOutlet weak var tLocationView: UIView!
    @IBOutlet weak var tLocationLabel: UILabel!
    
    @IBOutlet weak var tOriginaView: UIView!
    @IBOutlet weak var tOriginLabel: UILabel!
    
    
    
    
    var model: Character
    
    init(model: Character) {
        self.model = model
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        syncModel()
        
        backImage.image = UIImage(named: "w3")
        backImage.contentMode = .scaleToFill
        
        imageDetail.layer.cornerRadius = 90
        colorCharacter.layer.cornerRadius = 90
        colorStatus.layer.cornerRadius = 20
        nameLabel.font = UIFont(name: "Get Schwifty Regular", size: 36)
        nameLabel.textColor = UIColor(named: "rickHair")
        
        
        // Tabla
        detailTable.dataSource = self
        detailTable.delegate = self
        detailTable.register(UINib(nibName: "TableViewCell",
                                   bundle: nil),
                             forCellReuseIdentifier: "detailCell")
        
        detailTable.backgroundColor = UIColor.clear
        detailTable.backgroundView = UIView.init(frame: CGRect.zero)
        
        // Vista Datos importantes
        dataViewImportant.backgroundColor = .clear
        
        speciesView.layer.cornerRadius = 20
        tSpeciesView.layer.cornerRadius = 20
        speciesLabel.textColor = UIColor(named: "rickHair")
        speciesView.backgroundColor = UIColor(named: "dark")
        tSpeciesView.backgroundColor = UIColor(named: "dark")
        tSpeciesLabel.text = "Specie"
        
        typeView.layer.cornerRadius = 20
        tTypeView.layer.cornerRadius = 20
        typeLabel.textColor = UIColor(named: "rickHair")
        typeView.backgroundColor = UIColor(named: "dark")
        tTypeView.backgroundColor = UIColor(named: "dark")
        tTypeLabel.text = "Type"
        
        genderView.layer.cornerRadius = 20
        tGendeView.layer.cornerRadius = 20
        genderLabel.textColor = UIColor(named: "rickHair")
        genderView.backgroundColor = UIColor(named: "dark")
        tGendeView.backgroundColor = UIColor(named: "dark")
        tGenderLabel.text = "Gender"
        
        locationView.layer.cornerRadius = 20
        tLocationView.layer.cornerRadius = 20
        locationNameLabel.textColor = UIColor(named: "rickHair")
        locationView.backgroundColor = UIColor(named: "dark")
        tLocationView.backgroundColor = UIColor(named: "dark")
        tLocationLabel.text = "Location"
        
        originView.layer.cornerRadius = 20
        tOriginaView.layer.cornerRadius = 20
        originLabel.textColor = UIColor(named: "rickHair")
        originView.backgroundColor = UIColor(named: "dark")
        tOriginaView.backgroundColor = UIColor(named: "dark")
        tOriginLabel.text = "Origin"
        
    }
    
    func syncModel() {
        
        self.view.backgroundColor = UIColor(named: "dark")
        
        nameLabel.text = model.name
        statusLabel.text = model.status
        
        let imageUrl = model.image
        imageDetail.kf.setImage(with: URL(string: imageUrl))
        
        if model.status == "Alive" {
            colorStatus.backgroundColor = .green
            colorCharacter.backgroundColor = .green
        } else if model.status == "Dead" {
            colorStatus.backgroundColor = .red
            colorCharacter.backgroundColor = .red
        } else if model.status == "unknown" {
            colorStatus.backgroundColor = .gray
            colorCharacter.backgroundColor = .gray
        }
        speciesLabel.text = model.species
        if model.type == "" {
            typeLabel.text = "---"
        } else {
            typeLabel.text = model.type
        }
        genderLabel.text = model.gender
        locationNameLabel.text = model.location.name
        originLabel.text = model.origin.name
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return model.episode.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailCell = detailTable.dequeueReusableCell(withIdentifier: "detailCell") as! TableViewCell
        NetworkApi.shared.getEpisodes(url: model.episode[indexPath.row]) { episode in
            detailCell.dataLabel.text = episode.name
            detailCell.titleLabel.text = episode.episode
        } failure: { error in
            detailCell.dataLabel.text = "Error"
        }
        
        return detailCell
    }
}

extension DetailViewController: UITableViewDelegate {
    
}
