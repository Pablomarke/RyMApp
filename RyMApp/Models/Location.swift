//
//  Location.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 9/8/23.
//

import Foundation

struct Location: Decodable {
    let id: Int
    let name: String
    let type: String
    let residents: [String]
    
    init(_ id: Int, name: String, type: String, residents: [String]) {
        self.id = id
        self.name = name
        self.type = type
        self.residents = residents
        
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case type
        case residents
    }
}
