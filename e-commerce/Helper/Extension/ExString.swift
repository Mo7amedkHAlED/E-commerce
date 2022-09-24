//
//  ExString.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 24/09/2022.
//

import Foundation

import UIKit


extension String {
    
    var localized: String { // mean that when = nil i will retrun this NSLocalizedString
        return NSLocalizedString(self, comment: "")
    } // self mean who used this var
    
}


