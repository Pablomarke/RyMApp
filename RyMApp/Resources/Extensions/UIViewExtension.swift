//
//  UIViewExtension.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 5/12/23.
//

import UIKit

extension UIView {
    
    func cornerToTableView(corner: Int = 12){
        self.layer.cornerRadius = CGFloat(corner)
        self.backgroundColor = Color.secondColor
    }
    
    func cornerToView(corner: Int = 15){
        self.layer.cornerRadius = CGFloat(corner)
        self.backgroundColor = Color.secondColor
    }
    
    func cornerToImagedetailViews(corner: Int = 90){
        self.layer.cornerRadius = CGFloat(corner)
    }
}
