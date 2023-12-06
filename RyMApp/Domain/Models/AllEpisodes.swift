//
//  AllEpisodes.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 11/8/23.
//

import Foundation

struct AllEpisodes: Codable {
    let info: ApiInfo
    let results: [Episode]?
    
    enum CodingKeys: CodingKey {
        case info
        case results
    }
}
