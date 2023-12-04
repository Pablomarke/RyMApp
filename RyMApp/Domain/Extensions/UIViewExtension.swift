//
//  UIViewExtension.swift
//  RyMApp
//
//  Created by Pablo Márquez Marín on 5/12/23.
//

import UIKit

extension UIView {
    
    func corner12(){
        self.layer.cornerRadius = 12
        self.backgroundColor = color.secondColor
    }
    
    func corner15Second(){
        self.layer.cornerRadius = 15
        self.backgroundColor = color.secondColor
    }
}
