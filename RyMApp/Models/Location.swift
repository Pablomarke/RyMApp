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
    let dimension: String
    let residents: [String]
    let url: String
    
    init(_ id: Int, name: String, type: String, dimension: String, residents: [String], url: String) {
        self.id = id
        self.name = name
        self.type = type
        self.dimension = dimension
        self.residents = residents
        self.url = url

    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case type
        case dimension
        case residents
        case url
    }
}

struct SimpleLocation: Decodable {
    let name: String
    let url: String
    
    enum CodingKeys: CodingKey {
        case name
        case url
    }
}
