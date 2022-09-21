//
//  ChatTableViewCell.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 21/09/2022.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    @IBOutlet weak var StackView: UIStackView!
    @IBOutlet weak var ChatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
