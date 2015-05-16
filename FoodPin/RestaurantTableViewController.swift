//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Fenkins on 10/04/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    var fetchResultController:NSFetchedResultsController!
    var restaurants:[Restaurant] = []
    // Removing the array due to coreData integration
//        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", image: "cafedeadend.jpg", phone: "8-928-666-43-22", isVisited: true),
//        Restaurant(name: "Homei", type: "Cafe", location: "Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong", image: "homei.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "Teakha", type: "Tea House", location: "Shop B, 18 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", image: "teakha.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Shop B, 20 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", image: "cafeloisl.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "Petite Oyster", type: "French", location: "24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", image: "petiteoyster.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Shop J-K., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong", image: "forkeerestaurant.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "Po's Atelier", type: "Bakery", location: "G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong", image: "posatelier.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "633 Bourke St Sydney New South Wales 2010 Surry Hills", image: "bourkestreetbakery.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "412-414 George St Sydney New South Wales", image: "haighschocolate.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Shop 1 61 York St Sydney New South Wales", image: "palominoespresso.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "Upstate", type: "American", location: "95 1st Ave New York, NY 10003", image: "upstate.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "Traif", type: "American", location: "229 S 4th St Brooklyn, NY 11211", image: "traif.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "445 Graham Ave Brooklyn, NY 11211", image: "grahamavenuemeats.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "413 Graham Ave Brooklyn, NY 11211", image: "wafflewolf.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "18 Bedford Ave Brooklyn, NY 11222", image: "fiveleaves.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "Cafe Lore", type: "Latin American", location: "Sunset Park 4601 4th Ave Brooklyn, NY 11220", image: "cafelore.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "Confessional", type: "Spanish", location: "308 E 6th St New York, NY 10003", image: "confessional.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "Barrafina", type: "Spanish", location: "54 Frith Street London W1D 4SL United Kingdom", image: "barrafina.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "Donostia", type: "Spanish", location: "10 Seymour Place London W1H 7ND United Kingdom", image: "donostia.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "Royal Oak", type: "British", location: "2 Regency Street London SW1P 4BZ United Kingdom", image: "royaloak.jpg", phone: "8-928-666-43-22", isVisited: false),
//        Restaurant(name: "Thai Cafe", type: "Thai", location: "22 Charlwood Street London SW1V 2DY Pimlico", image: "thaicafe.jpg", phone: "8-928-666-43-22", isVisited: false)
    

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.restaurants.count
    }

    // Enabling hiding nav bar upon the loading of the view
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell_id", forIndexPath: indexPath) as! CustomTableViewCell
        // Configure the cell...
        let restaurant = restaurants[indexPath.row]
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
            self.restaurants.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
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
                destinationController.restaurantDetail = self.restaurants[indexPath.row]
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
