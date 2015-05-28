//
//  FeedDetailViewController.swift
//  FoodPin
//
//  Created by Fenkins on 27/05/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import UIKit

class FeedDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var restaurantImageView: UIImageView!
    
    var currentObject: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let object = currentObject {
            println("\(object)")
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! FeedDetailTableViewCell
        if let object = currentObject {
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = (object["name"] as! String)
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = (object["type"] as! String)
        case 2:
            cell.fieldLabel.text = "location"
            cell.valueLabel.text = (object["location"] as! String)
            let cellID = (object["location"] as! String)
            println("\(cell.valueLabel.text)")
            println("\(cellID)")
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
            }
        }
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
