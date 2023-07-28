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
    private let baseUrl = "https://rickandmortyapi.com/api/character/"
    
    func getCharacter(id: Int, success: @escaping (_ character: Character) -> (), failure: @escaping(_ error: Error?) -> () ){
        
        let newUrl = "https://rickandmortyapi.com/api/character/\(id)"
        
        AF.request(newUrl, method: .get).validate(statusCode: cstatusOk).responseDecodable (of: Character.self, decoder: DataDecoder()) { response in
            
            if let character = response.value {
                success(character)
                
            } else {
                failure(response.error)
            }
        }
    }
    
    func getAllCharacters(success: @escaping (_ allCharacters: AllCharacters) -> (), failure: @escaping(_ error: Error?) -> ()) {
       
        AF.request(baseUrl, method: .get).validate(statusCode: cstatusOk).responseDecodable(of: AllCharacters.self, decoder: DataDecoder()) { response in
            
            if let allCharacters = response.value {
                success(allCharacters)
            } else {
                failure(response.error)
            }
        }
        
    }
}
