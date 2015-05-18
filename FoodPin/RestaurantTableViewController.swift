//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Fenkins on 10/04/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    var fetchResultController:NSFetchedResultsController!
    var restaurants:[Restaurant] = []
    var searchController:UISearchController!
    var searchResults:[Restaurant] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Removing the title name from the NavigationBar
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // CoreData fetch
        var fetchRequest = NSFetchRequest(entityName: "Restaurant")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            var e: NSError?
            var result = fetchResultController.performFetch(&e)
            restaurants = fetchResultController.fetchedObjects as! [Restaurant]
            
            if result != true {
                println(e?.localizedDescription)
            }
        }
        
        // Search bar
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        // Making sure that search controller is presented within the bounds of the original table view controller
        definesPresentationContext = true
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if searchController.active {
            return searchResults.count
        } else {
            return self.restaurants.count
        }
    }

    // Enabling hiding nav bar upon the loading of the view
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell_id", forIndexPath: indexPath) as! CustomTableViewCell
        // Configure the cell...
        let restaurant = (searchController.active) ? searchResults[indexPath.row] : restaurants[indexPath.row]
        cell.nameLabel?.text = restaurants[indexPath.row].name
        // See this one and previous are effectively the same
        cell.locationLabel?.text = restaurant.location
        cell.typeLabel?.text = restaurant.type
        
        cell.thumbnailImageView?.image = UIImage(data: restaurant.image)
        
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
        cell.thumbnailImageView.clipsToBounds = true
        
        cell.beenHereImageView.image = UIImage(named: "heart")
        cell.beenHereImageView.hidden = true
        
        
        if restaurant.isVisited.boolValue {
//            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            cell.beenHereImageView.hidden = false
        }
        else {
//            cell.accessoryType = UITableViewCellAccessoryType.None
            cell.beenHereImageView.hidden = true
        }
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // or if editingStyle == .Delete
        if editingStyle == UITableViewCellEditingStyle.Delete {
            self.restaurants.removeAtIndex(indexPath.row)
        }
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        // or tableView.reloadData() to reload the whole view
        println("Total item: \(self.restaurants.count)")
        for name in restaurants {
            println(name)
        }
    }
    
    
    func checkArrayForAname (isRestaurantVisited:Bool) -> String {
        if  isRestaurantVisited == true {
            return "I have not been here"
        }
        else {
            return "I've been here before"

        }
    }
    

    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        var shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Share", handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
        
        let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.Default, handler: nil)
        let facebookAction = UIAlertAction(title: "FaceBook", style: UIAlertActionStyle.Default, handler: nil)
        let emailAction = UIAlertAction(title: "Mail it", style: UIAlertActionStyle.Default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        shareMenu.addAction(twitterAction)
        shareMenu.addAction(facebookAction)
        shareMenu.addAction(emailAction)
        shareMenu.addAction(cancelAction)
        
        self.presentViewController(shareMenu, animated: true, completion: nil)
        }
        )
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            // Delete the row from the data source
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
                
                let restaurantToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as! Restaurant
                managedObjectContext.deleteObject(restaurantToDelete)
                
                var e:NSError?
                if managedObjectContext.save(&e) != true {
                    println("delete error:\(e!.localizedDescription)")
                }
            }
            }
        )
        //set the color for the buttons
        shareAction.backgroundColor = UIColor(red: 72.0/255.0, green: 124.0/255.0, blue: 227.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 255.0/255.0, green: 12.0/255.0, blue: 2.0/255.0, alpha: 1.0)
        //return the array of UITableViewRowAction (those buttons)
        return [deleteAction, shareAction]
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                // going to make destinationController out of DetailViewController and then pass out our image name to the destination controller
                let destinationController = segue.destinationViewController as! DetailViewController
                // passing the restaurant object to the DetailViewController(to the restaurantDetail variable)
                destinationController.restaurantDetail = (searchController.active) ? searchResults[indexPath.row] : self.restaurants[indexPath.row]
            }
        }
    }
    
    // Core data-related table update
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        case .Update:
            tableView.reloadData()
        default:
            tableView.reloadData()
        }
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    // Content filtering
    func filterContentForSearchText(searchText:String) {
        searchResults = restaurants.filter({ (restaurant:Restaurant) -> Bool in
            let nameMatch = restaurant.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
println("\(nameMatch)")
            return nameMatch != nil
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText)
        tableView.reloadData()
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active {
            return false
        } else {
            return true
        }
        
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

}
