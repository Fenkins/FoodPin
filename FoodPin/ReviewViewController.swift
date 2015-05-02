//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Fenkins on 01/05/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var dialogView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //blur effect
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        //scaling
        dialogView.transform = CGAffineTransformMakeScale(0.0, 0.0)
        // Do any additional setup after loading the view.
        
    }

    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.8, delay: 0.0, options: nil, animations: {
            self.dialogView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        }, completion: nil)
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
