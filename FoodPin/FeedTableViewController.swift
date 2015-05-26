//
//  FeedTableViewController.swift
//  FoodPin
//
//  Created by Fenkins on 26/05/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import UIKit
import Parse
import Bolts

class FeedTableViewController: PFQueryTableViewController {
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "Countries"
        self.textKey = "nameEnglish"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
}
