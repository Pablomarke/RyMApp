//
//  ApiInfo.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 11/8/23.
//

import Foundation

struct ApiInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
    
    init(count: Int, pages: Int, next: String?, prev: String?) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }
    enum CodingKeys: CodingKey {
        case count
        case pages
        case next
        case prev
    }
}
