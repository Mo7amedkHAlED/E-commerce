//
//  ExUIView.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 15/08/2022.
//

import UIKit

extension UIView { 
    
    func addLayer(
        cornerRadius: CGFloat = 10,shadowColor: UIColor = UIColor.lightGray,shadowOffsetWidth: CGFloat = 2,shadowOffsetHeight: CGFloat = 3, shadowOpacity: CGFloat = 0.5){
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor.cgColor
        
        self.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        let shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius)
        self.layer.shadowPath = shadowPath.cgPath
        self.layer.shadowOpacity = Float(shadowOpacity)
    }
}
