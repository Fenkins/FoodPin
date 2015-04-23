//
//  DetailViewController.swift
//  FoodPin
//
//  Created by Fenkins on 21/04/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameView: UILabel!
    @IBOutlet weak var restaurantLocationView: UILabel!
    @IBOutlet weak var restaurantTypeView: UILabel!
    
    var restaurantImage:String!
    var restaurantName:String!
    var restaurantLocation:String!
    var restaurantType:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.restaurantImageView.image = UIImage(named: restaurantImage)
        self.restaurantNameView.text = restaurantName
        self.restaurantLocationView.text = restaurantLocation
        self.restaurantTypeView.text = restaurantType
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
