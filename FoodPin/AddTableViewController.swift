//
//  AddTableViewController.swift
//  FoodPin
//
//  Created by Fenkins on 10/05/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import UIKit
import CoreData

class AddTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var beenHereButtonYesOut: UIButton!
    @IBOutlet weak var beenHereButtonNoOut: UIButton!
    
    @IBAction func beenHereButtonYES(sender: AnyObject) {beenHereButtonYesOut.backgroundColor = UIColor.grayColor()
        isVisited = true
    }
    @IBAction func beenHereButtonNO(sender: AnyObject) {beenHereButtonNoOut.backgroundColor = UIColor(red: 240.0/255.0, green: 89.0/255.0, blue: 55.0/255.0, alpha: 1.0)
        isVisited = false
    }
    @IBAction func barButtonItemSave(sender: AnyObject) { saveAction(nameTextField, type: typeTextField, location: locationTextField, phone: phoneTextField)
    }
    
    var restaurant:Restaurant!
    var isVisited:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                imagePicker.delegate = self
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    
    func saveAction(name:UITextField, type:UITextField, location:UITextField, phone:UITextField) {
        if name.text!.isEmpty || type.text!.isEmpty || location.text!.isEmpty || phone.text!.isEmpty {
            let fillSomeTextInController = UIAlertController(title: "You forgot to fill some text", message: "Please fill all the fields to proceed", preferredStyle: UIAlertControllerStyle.Alert)
            fillSomeTextInController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(fillSomeTextInController, animated: true, completion: nil)
            
        }
        else {
            print("Restaurant info received")
            print("Name of the restaurant is "  + "\(name.text)")
            print("Restaurant type is " + "\(type.text)")
            print("Restaurant located " + "\(location.text)")
            print("Restaurant phone nmbr \(phone.text)")
            
            
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
                
                restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: managedObjectContext) as! Restaurant
                restaurant.name = nameTextField.text
                restaurant.type = typeTextField.text
                restaurant.location = locationTextField.text
                restaurant.phone = phoneTextField.text
                restaurant.image = UIImagePNGRepresentation(imageView.image!)
                restaurant.isVisited = isVisited
                
                var e: NSError?
                if managedObjectContext.save(&e) != true {
                    print("insert error:\(e!.localizedDescription)")
                    return
                }
            }
            
            
            performSegueWithIdentifier("unwindToHomeScreen", sender: self)
        }
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
