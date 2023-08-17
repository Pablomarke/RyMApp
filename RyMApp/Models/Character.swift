//
//  Character.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 27/7/23.
//

import Foundation
import UIKit


struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let image: String
    let created: Date
    let species: String
    let gender: String
    let type: String
    let location: SimpleLocation
    let origin: SimpleLocation
    let episode: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case created
        case image
        case species
        case gender
        case type
        case location
        case origin
        case episode
    }
}


