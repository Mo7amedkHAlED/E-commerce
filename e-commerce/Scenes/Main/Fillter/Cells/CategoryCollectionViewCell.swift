//
//  CategoryCollectionViewCell.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 29/09/2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool {
        didSet{
            self.categoryView.backgroundColor = isSelected ? .red : .white
            self.categoryLBL.textColor = isSelected ? .white : .black
            //self.categoryView.layer.borderWidth = isSelected ? 1 :  0
        }
    }
     
}
