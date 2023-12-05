//
//  AllLocations.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 11/8/23.
//

import Foundation

struct AllLocations: Codable {
    let info: ApiInfo
    let results: [Location]
    
    enum CodingKeys: CodingKey {
        case info
        case results
    }
}
