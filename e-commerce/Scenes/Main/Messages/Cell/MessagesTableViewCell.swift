//
//  MessagesTableViewCell.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 20/09/2022.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var MesssageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        productImage.layer.cornerRadius = productImage.frame.height/2 // to make image as circle 
        
        
    }
    
}
