//
//  CustomTableViewCell.swift
//  FoodPin
//
//  Created by Fenkins on 10/04/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

@IBOutlet weak var nameLabel: UILabel!
@IBOutlet weak var locationLabel: UILabel!
@IBOutlet weak var typeLabel: UILabel!
@IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
