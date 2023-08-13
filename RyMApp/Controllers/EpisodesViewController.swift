//
//  EpisodesViewController.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 11/8/23.
//

import UIKit

class EpisodesViewController: UIViewController {
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var episodeTable: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tabBarEpisode: UITabBar!
    
    var model: AllEpisodes
    
    init(_ model: AllEpisodes) {
        self.model = model
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Episodios"
        titleLabel.font = UIFont(name: "Get Schwifty Regular", size: 32)
        titleLabel.textColor = UIColor(named: "rickHair")
        titleLabel.numberOfLines = 0
        
        self.view.backgroundColor = UIColor(named: "dark")
        tabBarEpisode.barTintColor = UIColor(named: "dark")
        tabBarEpisode.isTranslucent = false
        tabBarEpisode.tintColor = UIColor(named: "rickHair")
        
        episodeTable.dataSource = self
        episodeTable.delegate = self
        episodeTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TC")
        episodeTable.backgroundColor = .clear
        
    }
}

extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return model.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = episodeTable.dequeueReusableCell(withIdentifier: "TC") as! TableViewCell?
        cell?.titleLabel.text = model.results?[indexPath.row].episode
        cell?.dataLabel.text = model.results?[indexPath.row].name
        cell?.titleLabel.textColor = .black
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NetworkApi.shared.getEpisode(url: (model.results?[indexPath.row].url)!) { episode in
            let detail = EpisodeDetailViewController(episode)
            self.navigationController?.pushViewController(detail,
                                                          animated: true)
        } failure: { error in
            self.titleLabel.text = "Error"
        }
        
    }
}

