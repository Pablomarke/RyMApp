//
//  DataDecoder.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 28/7/23.
//

import Foundation

final class DataDecoder: JSONDecoder {
    
    let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateDecodingStrategy = .formatted(dateFormatter)
    }
    
    func dateToString(date: Date) -> String {
        let myDate = DateFormatter()
        myDate.dateStyle = .short
        let newDate = myDate.string(from: date)
        return newDate
    }
}
