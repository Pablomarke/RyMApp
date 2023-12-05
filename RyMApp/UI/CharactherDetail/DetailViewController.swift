//
//  DetailViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 27/7/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - IBOutlets -
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var colorCharacter: UIView!
    @IBOutlet weak var colorStatus: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    
    @IBOutlet weak var episodeTable: UITableView!
    
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
    
    // MARK: - Propiedades -
    var model: Character
    
    // MARK: - Init -
    init(
        model: Character
    ) {
        self.model = model
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError(
            "init(coder:) has not been implemented"
        )
    }
    
    // MARK: - Ciclo de vida -
    override func viewDidLoad() {
        super.viewDidLoad()
        syncCharacterModelwithView()
        
        backImage.image = LocalImages.detailImage
        backImage.contentMode = .scaleToFill
        imageDetail.layer.cornerRadius = 90
        colorCharacter.layer.cornerRadius = 90
        colorStatus.layer.cornerRadius = 20
        nameLabel.font = Font.size36
        nameLabel.textColor = Color.secondColor
        
        // Tabla
        episodeTable.dataSource = self
        episodeTable.delegate = self
        episodeTable.register(
            UINib(
                nibName: TableViewCell.identifier,
                bundle: nil
            ),
            forCellReuseIdentifier: TableViewCell.identifier
        )
        
        episodeTable.backgroundColor = Color.clearColor
        episodeTable.backgroundView = UIView.init(
            frame: CGRect.zero
        )
        
        // Vista Datos importantes
        speciesView.corner15Second()
        tSpeciesView.corner15Second()
        speciesLabel.textColor = Color.mainColor
        tSpeciesLabel.text = "Specie"
        
        typeView.corner15Second()
        tTypeView.corner15Second()
        typeLabel.textColor = Color.mainColor
        tTypeLabel.text = "Type"
        
        genderView.corner15Second()
        tGendeView.corner15Second()
        genderLabel.textColor = Color.mainColor
        tGenderLabel.text = "Gender"
        
        locationView.corner15Second()
        tLocationView.corner15Second()
        locationNameLabel.textColor = Color.mainColor
        tLocationLabel.text = "Location"
        
        originView.corner15Second()
        tOriginaView.corner15Second()
        originLabel.textColor = Color.mainColor
        tOriginLabel.text = "Origin"
        
    }
    
    // MARK: - Funciones -
    func syncCharacterModelwithView() {
        nameLabel.text = model.name
        statusLabel.text = model.status
        let imageUrl = model.image
        imageDetail.kf.setImage(
            with: URL(
                string: imageUrl
            )
        )
        genderLabel.text = model.gender
        locationNameLabel.text = model.location.name
        originLabel.text = model.origin.name
        
        self.view.backgroundColor = Color.mainColor
        colorStatus.backgroundColor = model.statusColor()
        colorCharacter.backgroundColor = model.statusColor()
        
        speciesLabel.text = model.species
        if model.type == "" {
            typeLabel.text = "---"
        } else {
            typeLabel.text = model.type
        }
    }
}
// MARK: - Extension de datasource -
extension DetailViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return model.episode.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let detailCell = episodeTable.dequeueReusableCell(
            withIdentifier: TableViewCell.identifier
        ) as! TableViewCell
        NetworkApi.shared.getEpisode(
            url: model.episode[indexPath.row]
        ) { episode in
            detailCell.syncEpisodeWithCell(model: episode)
        }
        return detailCell
    }
}

// MARK: - Extension de delegado -
extension DetailViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        NetworkApi.shared.getEpisode(
            url: model.episode[indexPath.row]
        ) { episode in
            let episodeNav = EpisodeDetailViewController(
                episode
            )
            self.navigationController?.showDetailViewController(
                episodeNav,
                sender: nil
            )
        }
    }
}
