//
//  FeedDetailTableViewCell.swift
//  FoodPin
//
//  Created by Fenkins on 27/05/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import UIKit

class FeedDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var mapButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
