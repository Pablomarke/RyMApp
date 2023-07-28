//
//  allCharacters.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 28/7/23.
//

import Foundation

struct AllCharacters: Decodable {
    let results: [Character]?
    
    init(results: [Character]?) {
        self.results = results
    }
    
    enum CodingKeys: CodingKey {
        case results
        
    }
}


