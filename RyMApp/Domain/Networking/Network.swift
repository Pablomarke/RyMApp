//
//  Network.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 27/7/23.
//

import Foundation
//import Alamofire

class NetworkApi {
    static let shared = NetworkApi()
    private let cstatusOk = 200...299
    private let baseUrl = "https://rickandmortyapi.com/api/"
    
    enum endpoint {
        static let allCharacters = "character/"
        static let allEpisodes = "episode/"
        static let name = "character/?name="
        static let allLocations = "location/"
        
    }
    enum httpMethods {
        static let get = "GET"
    }
    
    // MARK: Characters
    func getAllCharacters(completion: @escaping (AllCharacters) -> Void){
        let characterURl = baseUrl + endpoint.allCharacters
        guard let url = URL(string: characterURl) else {return}
        var urlRequest = URLRequest(url: url )
        urlRequest.httpMethod = httpMethods.get
        
        URLSession.shared.dataTask(with: urlRequest) {data,response,error in
           DispatchQueue.main.async {
                guard let data,
                      (response as? HTTPURLResponse)?.statusCode == 200 else { return }
                guard error == nil else {return}

                guard let allCharacters = try? DataDecoder().decode(AllCharacters.self ,from: data) else { return }
                completion(allCharacters)
            }
        }.resume()
    }

    func getCharacter(id: Int, completion: @escaping (_ character: Character) -> ()){
        let idUrl = baseUrl + endpoint.allCharacters + "\(id)"
        guard let url = URL(string: idUrl) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethods.get
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                guard let data, (response as? HTTPURLResponse)?.statusCode == 200 else { return }
                guard error == nil else {return}
                guard let character = try? DataDecoder().decode(Character.self, from: data) else { return }
                completion(character)
            }
        }.resume()
    }
    
    func searchCharacters(name: String, completion: @escaping (_ allCharacters: AllCharacters) -> ()) {
        let searchUrl = baseUrl + "\(name)"
        guard let url = URL(string: searchUrl) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethods.get
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                guard let data, (response as? HTTPURLResponse)?.statusCode == 200 else { return }
                guard error == nil else {return}
                guard let character = try? DataDecoder().decode(AllCharacters.self, from: data) else { return }
                completion(character)
            }
        }.resume()
    }
    
    // MARK: Episodes
    func getAllEpisodes(completion: @escaping (_ episodes: AllEpisodes) -> ()){
        let allEpisodesUrl = baseUrl + endpoint.allEpisodes
        guard let url = URL(string: allEpisodesUrl) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethods.get
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                guard let data, (response as? HTTPURLResponse)?.statusCode == 200 else { return }
                guard error == nil else {return}
                guard let character = try? DataDecoder().decode(AllEpisodes.self, from: data) else { return }
                completion(character)
            }
        }.resume()
    }
    
    func getEpisode(url: String, completion: @escaping (_ episode: Episode) -> ()) {
        guard let url = URL(string: url) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethods.get
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                guard let data, (response as? HTTPURLResponse)?.statusCode == 200 else { return }
                guard error == nil else {return}
                guard let episodes = try? DataDecoder().decode(Episode.self, from: data) else { return }
                completion(episodes)
            }
        }.resume()
    }
    
    func getArrayEpisodes(season: String,
                          completion: @escaping(_ episodes: [Episode]) -> ()
                          ) {
        
        let seasonsUrl = baseUrl + endpoint.allEpisodes + "\(season)"
        
    }
    
    // MARK: Locations
    func getAllLocations(completion: @escaping(_ location: AllLocations) -> ()) {
        let locationsUrl = baseUrl + endpoint.allLocations
       
    }
    
    
    
    
    
    // MARK: Pages
    func pages(url: String, completion: @escaping (_ allCharacters: AllCharacters) -> ()) {
        
    }
    
    func pagesLocation(url: String, completion: @escaping (_ allLocations: AllLocations) -> ()) {
       
    }
    func getCharacterUrl(url: String, completion: @escaping (_ character: Character) -> ()) {
        
    }
    func getLocationUrl(url: String, completion: @escaping (_ location: Location) -> ()) {
        
    }
    func getAllLocationsUrl(url: String, completion: @escaping (_ locations: AllLocations) -> ()) {
        
        let allLUrl = baseUrl + "episode/"
        
    }
}

