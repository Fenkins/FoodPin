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
    // constraints
    @IBOutlet weak var shareLabelToTopConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // blurry background
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        // we will make width/height double so blurred background fit the gap on rotated screen
        blurEffectView.frame = CGRectMake(view.bounds.origin.x, view.bounds.origin.y, view.bounds.width * 2, view.bounds.height * 2)
        backgroundImageView.addSubview(blurEffectView)
        // Do any additional setup after loading the view.
        
        // Setting the starting point for animation
        let scale = CGAffineTransformMakeScale(0, 0)
        let translateTop = CGAffineTransformMakeTranslation(0, -500)
        let translateBottom = CGAffineTransformMakeTranslation(0, 500)
        facebookButton.transform = CGAffineTransformConcat(scale, translateBottom)
        twitterButton.transform = CGAffineTransformConcat(scale, translateTop)
        messagesButton.transform = CGAffineTransformConcat(scale, translateBottom)
        emailButton.transform = CGAffineTransformConcat(scale, translateTop)
        
        println("viewDidLoad " + "\(shareLabelToTopConstraint.constant)")
        
        // watch for device orientation
        var orientation = UIApplication.sharedApplication().statusBarOrientation
        if orientation == UIInterfaceOrientation.LandscapeLeft {
        shareLabelToTopConstraint.constant += 100.0
        } else if orientation == UIInterfaceOrientation.LandscapeRight {
        shareLabelToTopConstraint.constant += 100.0
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        // Setting the end point for animation
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: nil, animations: {
            let scale = CGAffineTransformMakeScale(1.0, 1.0)
            let translate = CGAffineTransformMakeTranslation(0, 0)
            self.facebookButton.transform = CGAffineTransformConcat(scale, translate)
            self.emailButton.transform = CGAffineTransformConcat(scale, translate)
        }, completion: nil)
        UIView.animateWithDuration(0.3, delay: 0.4, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: nil, animations: {
            let scale = CGAffineTransformMakeScale(1.0, 1.0)
            let translate = CGAffineTransformMakeTranslation(0, 0)
            self.twitterButton.transform = CGAffineTransformConcat(scale, translate)
            self.messagesButton.transform = CGAffineTransformConcat(scale, translate)
        }, completion: nil)
        
        println("viewDidAppear " + "\(shareLabelToTopConstraint.constant)")
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        if UIInterfaceOrientationIsLandscape(toInterfaceOrientation) && shareLabelToTopConstraint.constant != 0 {
            shareLabelToTopConstraint.constant += 100.0
        }
        else if UIInterfaceOrientationIsPortrait(toInterfaceOrientation) {
            shareLabelToTopConstraint.constant -= 100.0
        }
        
        if shareLabelToTopConstraint.constant > 100 {
            shareLabelToTopConstraint.constant = 100
        }
        
        println("willRotate " + "\(shareLabelToTopConstraint.constant)")
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
