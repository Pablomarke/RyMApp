//
//  ApiInfo.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 11/8/23.
//

import Foundation

struct ApiInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
    
    enum CodingKeys: CodingKey {
        case count
        case pages
        case next
        case prev
    }
}
