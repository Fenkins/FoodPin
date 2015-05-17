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
    // Creating variables to use with blurEffect
    var blurEffect:UIBlurEffect!
    var blurEffectView:UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initial point for scaling or spring
        // dialogView.transform = CGAffineTransformMakeScale(0.0, 0.0)
        
        // initian point for sliding up
        //dialogView.transform = CGAffineTransformMakeTranslation(0, 500)

        // animation concatination
        let scale = CGAffineTransformMakeScale(0.0, 0.0)
        let translate = CGAffineTransformMakeTranslation(0, 500)
        dialogView.transform = CGAffineTransformConcat(scale, translate)
        
        // Setting nessessary stuff and adding subview
        blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        backgroundImageView.addSubview(blurEffectView)
        
        // Constraints block
        // Not sure if i need that particular line
        blurEffectView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var constrWidth = NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: backgroundImageView, attribute: NSLayoutAttribute.Width, multiplier: 2.0, constant: 0)
        backgroundImageView.addConstraint(constrWidth)
        
        var constrHeight = NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: backgroundImageView, attribute: NSLayoutAttribute.Height, multiplier: 2.0, constant: 0)
        backgroundImageView.addConstraint(constrHeight)

    }
    
//    override func viewDidLayoutSubviews() {
//        // blur effect
//        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
//        var blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = backgroundImageView.bounds
//        backgroundImageView.addSubview(blurEffectView)
//    }
    
    override func viewWillLayoutSubviews() {
        // Configuring frame before viewDidAppear
        blurEffectView.frame = backgroundImageView.bounds
    }

    override func viewDidAppear(animated: Bool) {
        // popup animation
//        UIView.animateWithDuration(0.2, delay: 0.0, options: nil, animations: {
//            self.dialogView.transform = CGAffineTransformMakeScale(1.0, 1.0)
//        }, completion: nil)
        
        // spring animation
//        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: nil, animations: {
//            self.dialogView.transform = CGAffineTransformMakeScale(1.0, 1.0)
//        }, completion: nil)
        
        // moving up
//        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: nil, animations: {
//            self.dialogView.transform = CGAffineTransformMakeTranslation(0.0, 0.0)
//        }, completion: nil)

        // animation concat
        UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: nil, animations: {
            let scale = CGAffineTransformMakeScale(1.0, 1.0)
            let translate = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformConcat(scale, translate)
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
