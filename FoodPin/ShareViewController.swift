//
//  ShareViewController.swift
//  FoodPin
//
//  Created by Fenkins on 03/05/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var messagesButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // blurry background
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
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
