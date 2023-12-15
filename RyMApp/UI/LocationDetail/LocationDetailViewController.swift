//
//  LocationDetailViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 15/8/23.
//

import UIKit

class LocationDetailViewController: UIViewController {
    //MARK: - IBOutlets -
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dimensionLabel: UILabel!
    @IBOutlet weak var residentsLabel: UILabel!
    @IBOutlet weak var residentsCollection: UICollectionView!
    
    // MARK: - Propiedades -
    var model: Location
    
    // MARK: - Init -
    init(_ model: Location) {
        self.model = model
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Ciclo de vida -
    override func viewDidLoad() {
        super.viewDidLoad()
        viewStyle()
        syncModelWithView()
        createResidentCollection()
    }
    
    // MARK: - Funciones -
    func viewStyle(){
        self.view.backgroundColor = Color.mainColor
        backImage.image = LocalImages.locationDetailImage
        backImage.contentMode = .scaleToFill
        topView.backgroundColor = .clear
        nameLabel.font = Font.size24
        nameLabel.textColor = Color.secondColor
        nameLabel.numberOfLines = 2
        typeLabel.textColor = Color.secondColor
        typeLabel.numberOfLines = 2
        dimensionLabel.textColor = Color.secondColor
        dimensionLabel.numberOfLines = 2
        residentsLabel.textColor = Color.secondColor
    }
    
    func syncModelWithView() {
        nameLabel.text = model.name
        typeLabel.text = model.type
        dimensionLabel.text = model.dimension
        if model.residents.count != 0 {
            residentsLabel.text = "Residents"
        } else {
            residentsLabel.text = "No residents found"
        }
    }
    
    func createResidentCollection(){
        residentsCollection.backgroundColor = .clear
        residentsCollection.dataSource = self
        residentsCollection.delegate = self
        residentsCollection.register(UINib(nibName: CharacterCell.identifier, bundle: nil),
                                     forCellWithReuseIdentifier: CharacterCell.identifier)
    }
}

// MARK: - Extension de datasource -
extension LocationDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return model.residents.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = residentsCollection.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier,
                                                           for: indexPath) as! CharacterCell
        NetworkApi.shared.getCharacterUrl(url: model.residents[indexPath.row]) { character in
            cell.syncCellWithModel(model: character)
        }
        return cell
    }
}

// MARK: - Extension de delegate -
extension LocationDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, 
                        didSelectItemAt indexPath: IndexPath) {
        NetworkApi.shared.getCharacterUrl(url: model.residents[indexPath.row]) { character in
            let detailView = DetailViewController(model: character)
            self.navigationController?.showDetailViewController(detailView,
                                                                sender: nil)
        }
    }
}
