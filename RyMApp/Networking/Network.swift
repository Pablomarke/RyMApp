//
//  Network.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 27/7/23.
//

import Foundation
import Alamofire

class NetworkApi {
    
    static let shared = NetworkApi()
    private let cstatusOk = 200...299
    private let baseUrl = "https://rickandmortyapi.com/api/"
    
    
    // MARK: Characters
    func getAllCharacters(success: @escaping (_ allCharacters: AllCharacters) -> (),
                          failure: @escaping(_ error: Error?) -> ()) {
        let allCUrl = baseUrl + "character/"
        AF.request(allCUrl,
                   method: .get).validate(statusCode: cstatusOk).responseDecodable(of: AllCharacters.self,
                                                                                   decoder: DataDecoder()) { response in
                       
                       if let allCharacters = response.value {
                           success(allCharacters)
                       } else {
                           failure(response.error)
                       }
                   }
        
    }
    
    func getCharacter(id: Int, success: @escaping (_ character: Character) -> (), failure: @escaping(_ error: Error?) -> () ){
        
        let newUrl = baseUrl + "character/\(id)"
        
        AF.request(newUrl, method: .get).validate(statusCode: cstatusOk).responseDecodable (of: Character.self, decoder: DataDecoder()) { response in
            
            if let character = response.value {
                success(character)
                
            } else {
                failure(response.error)
            }
        }
    }
    
    
    
    func searchCharacters(name: String, success: @escaping (_ allCharacters: AllCharacters) -> (), failure: @escaping(_ error: Error?) -> ()) {
        let searchUrl = baseUrl + "character/?name=\(name)"
        
        AF.request(searchUrl, method: .get).validate(statusCode: cstatusOk).responseDecodable(of: AllCharacters.self, decoder: DataDecoder()) { response in
            if let allCharacters = response.value {
                success(allCharacters)
            } else {
                failure(response.error)
            }
        }
    }
    
    func getCharacterUrl(url: String, success: @escaping (_ character: Character) -> (),
                         failure: @escaping(_ error: Error?) -> ()) {
        
        AF.request(url, method: .get).validate(statusCode: cstatusOk).responseDecodable(of: Character.self, decoder: DataDecoder()) { response in
            if let character = response.value {
                success(character)
            } else {
                failure(response.error)
            }
        }
    }
    
    
    // MARK: Episodes
    func getAllEpisodes(success: @escaping (_ episodes: AllEpisodes) -> (),
                        failure: @escaping(_ error: Error?) -> ()){
        let allEUrl = baseUrl + "episode/"
        
        AF.request(allEUrl, method: .get).validate(statusCode: cstatusOk).responseDecodable(of: AllEpisodes.self, decoder: DataDecoder()) {
            response in
            
            if let episodes = response.value {
                success(episodes)
            } else {
                failure(response.error)
            }
        }
    }
    
    func getEpisode(url: String, success: @escaping (_ episode: Episode) -> (),
                    failure: @escaping(_ error: Error?) -> ()) {
        
        AF.request(url, method: .get).validate(statusCode: cstatusOk).responseDecodable(of: Episode.self, decoder: DataDecoder()) { response in
            if let episode = response.value {
                success(episode)
            } else {
                failure(response.error)
            }
        }
    }
    
    func getArrayEpisodes(season: String,
                          success: @escaping(_ episodes: [Episode]) -> (),
                          failure: @escaping(_ error: Error?) -> ()) {
    
            var seasonsUrl = baseUrl + "episode/\(season)"
        AF.request(seasonsUrl, method: .get).validate(statusCode: cstatusOk).responseDecodable(of: [Episode].self, decoder: DataDecoder()) { response in
            if let season = response.value {
                success(season)
            } else {
                failure(response.error)
            }
        }
    }
    
    // MARK: Locations
    func getAllLocations(succes: @escaping(_ location: AllLocations) -> (),
                         failure: @escaping(_ error: Error?) -> ()) {
        let locationsUrl = baseUrl + "location"
        AF.request(locationsUrl, method: .get).validate(statusCode: cstatusOk).responseDecodable(of: AllLocations.self, decoder: DataDecoder()) { response in
            if let allLocations = response.value {
                succes(allLocations)
            } else {
                failure(response.error)
            }
        }
    }
    
    func getLocationsUrl(url: String, success: @escaping (_ locations: AllLocations) -> (),
                         failure:@escaping(_ error: Error?) -> ()) {
        
        let allLUrl = baseUrl + "episode/"
        AF.request(allLUrl, method: .get).validate(statusCode: cstatusOk).responseDecodable(of: AllLocations.self, decoder: DataDecoder()) {
            response in
            
            if let locations = response.value {
                success(locations)
            } else {
                failure(response.error)
            }
        }
    }

    func getLocationUrl(url: String, success: @escaping (_ location: Location) -> (), failure: @escaping(_ error: Error?) -> ()) {
        
        AF.request(url, method: .get).validate(statusCode: cstatusOk).responseDecodable(of: Location.self, decoder: DataDecoder()) { response in
            if let location = response.value {
                success(location)
            } else {
                failure(response.error)
            }
        }
    }
    
    // MARK: Pages
    func pages(url: String, success: @escaping (_ allCharacters: AllCharacters) -> (),
               failure: @escaping(_ error: Error?) -> ()) {
        
        AF.request(url, method: .get).validate(statusCode: cstatusOk).responseDecodable(of: AllCharacters.self, decoder: DataDecoder()) { response in
            if let allCharacters = response.value {
                success(allCharacters)
            } else {
                failure(response.error)
            }
        }
    }
    
}
