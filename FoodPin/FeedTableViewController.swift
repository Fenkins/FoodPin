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
    
    @IBAction func unwindToHomeScreen (segue:UIStoryboardSegue){
    
    }

    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "Restaurant"
        self.textKey = "name"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: "Restaurant")
        query.orderByAscending("name")
        return query
    }
    
    // override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object:PFObject?) -> PFTableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! PFTableViewCell?
        // In case of initial object creation fails, we are making sure. That is recommended by parse, so whatever
        if cell == nil {
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        // Extract values from the PFObject to display in the table cell
        if let name = object?["name"] as? String {
            cell!.textLabel?.text = name
        }
        if let type = object?["type"] as? String {
            cell!.detailTextLabel?.text = type
        }
        
        return cell!
    }
    
    // We should build the segue before navigation. To pass stuff to another controller, you know
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showFeedDetail" {
        // Getting the new controller using [segue destinationViewController]
        var detailScene = segue.destinationViewController as! FeedDetailViewController
        
        // Passing the object we will need to destination view controller
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            let row = Int(indexPath.row)
            detailScene.currentObject = (objects?[row] as! PFObject)
            }
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
        // We could also return 0 if we dont want some items to be editable
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Deleting the row from the dataSource(datebase)
            let objectToDelete = objects?[indexPath.row] as! PFObject
            objectToDelete.deleteInBackgroundWithBlock {(success: Bool, error: NSError?) -> Void in
                if (success) {
                   // reloading the tableView on success
                    self.loadObjects()
                    tableView.reloadData()
                    println("EVERYTHING IS FINE DUDE CHILL")
                }
                else {
                    println("\(error)")
                }
            }
        }
    }
    
}
