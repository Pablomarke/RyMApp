//
//  Location.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 9/8/23.
//

import Foundation

typealias Locations = [Location]

struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case type
        case dimension
        case residents
        case url
    }
}

struct SimpleLocation: Codable {
    let name: String
    let url: String
    
    enum CodingKeys: CodingKey {
        case name
        case url
    }
}

