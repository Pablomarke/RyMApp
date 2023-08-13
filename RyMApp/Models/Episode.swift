//
//  Episode.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 9/8/23.
//

import Foundation

struct Episode: Decodable {
    let name: String
    let episode: String
    let characters: [String]
    let url: String
    
    enum CodingKeys: CodingKey {
        case name
        case episode
        case characters
        case url
    }
}
