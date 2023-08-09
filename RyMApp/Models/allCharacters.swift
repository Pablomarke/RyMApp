//
//  allCharacters.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 28/7/23.
//

import Foundation

struct AllCharacters: Decodable {
    let results: [Character]?
    let info: CharacterInfo?
    
    init(results: [Character]?,
         info: CharacterInfo?) {
        self.info = info
        self.results = results
    }
    
    enum CodingKeys: CodingKey {
        case info
        case results
        
    }
}

struct CharacterInfo: Decodable {
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

