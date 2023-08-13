//
//  LocationViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 13/8/23.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var model: AllLocations
    
    init(_ model: AllLocations) {
        self.model = model
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = String(model.results.count)
        
    }

}
