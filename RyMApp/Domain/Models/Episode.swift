//
//  Episode.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 9/8/23.
//

import Foundation

typealias Episodes = [Episode]

struct Episode: Codable {
    let name: String
    let episode: String
    let characters: [String]
    let url: String
    let air_date: String
    
    enum CodingKeys: CodingKey {
        case name
        case episode
        case characters
        case url
        case air_date
    }
}
