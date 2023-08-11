//
//  allCharacters.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 28/7/23.
//

import Foundation

struct AllCharacters: Decodable {
    let results: [Character]?
    let info: ApiInfo?
    
    init(results: [Character]?,
         info: ApiInfo?) {
        self.info = info
        self.results = results
    }
    
    enum CodingKeys: CodingKey {
        case info
        case results
        
    }
}



