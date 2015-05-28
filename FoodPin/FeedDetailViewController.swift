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
    @IBOutlet weak var restaurantImageView: PFImageView!
    
    var currentObject: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let object = currentObject {
            let pfimage = object["image"] as! PFFile
            
            pfimage.getDataInBackgroundWithBlock({(result, error) in
                self.restaurantImageView.image = UIImage(data: result!)
            })
            
            // Its important we set up these two in order to make code work. You could also do that in storyboard
            tableView.delegate = self
            tableView.dataSource = self
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! FeedDetailTableViewCell
        if let object = currentObject {
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = (object["name"] as! String)
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = (object["type"] as! String)
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = (object["location"] as! String)
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
