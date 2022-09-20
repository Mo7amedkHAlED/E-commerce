//
//  SubCategoriesCollectionViewCell.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 24/08/2022.
//

import UIKit

class SubCategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.layer.cornerRadius = 8
    }

}
