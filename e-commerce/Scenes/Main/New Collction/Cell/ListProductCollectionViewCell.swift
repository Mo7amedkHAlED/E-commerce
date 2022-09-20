//
//  ListProductCollectionViewCell.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 31/08/2022.
//

import UIKit

class ListProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        productImage.layer.cornerRadius = 8
    }

}
