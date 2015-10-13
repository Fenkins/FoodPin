//
//  PageContentViewController.swift
//  FoodPin
//
//  Created by Fenkins on 21/05/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var subHeadingLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var pageIndication: UIPageControl!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBAction func dismissViewControllerAnimated(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "hasViewedWalktrough")
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func nextScreen(sender: AnyObject) {
        let pageViewController = self.parentViewController as? PageViewController
        pageViewController!.forward(index)
    }
    
    var index: Int = 0
    var heading: String = ""
    var subHeading: String = ""
    var imageFile: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PageContentViewController viewDidLoad Executed")
        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        contentImageView.image = UIImage(named: imageFile)
        pageIndication.currentPage = index
        forwardButton.hidden = (index == 2) ? true : false
        getStartedButton.hidden = (index == 2) ? false : true
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
