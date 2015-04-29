//
//  DetailViewController.swift
//  FoodPin
//
//  Created by Fenkins on 21/04/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var restaurantDetail:Restaurant!
    
    var restaurantImage:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.restaurantImageView.image = UIImage(named: restaurantDetail.image)
        self.tableView.backgroundColor = UIColor(red: 230.0/255.0, green: 123.0/255.0, blue: 64.0/255.0, alpha: 0.180)
        // Getting rid of those separators
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        // Changing the separators color
        self.tableView.separatorColor = UIColor(red: 230.0/255.0, green: 123.0/255.0, blue: 64.0/255.0, alpha: 0.8)
        // Setting the NavigationBar title for DetailViewController
        title = self.restaurantDetail.name
        // Self sizing cells
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Disable hiding nav bar upon the loading of the view
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DetailTableViewCell
        
        //clearing the background color of the cell so we could see the background color of the table
        cell.backgroundColor = UIColor.clearColor()
        // configure the cell
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurantDetail.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurantDetail.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurantDetail.location
        case 3:
            cell.fieldLabel.text = "Been here"
            cell.valueLabel.text = restaurantDetail.isVisited ? "Yes I've been here before" : "No"
        case 4:
            cell.fieldLabel.text = "Call us"
            cell.valueLabel.text = restaurantDetail.phone
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
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
