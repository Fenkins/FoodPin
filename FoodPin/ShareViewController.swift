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
        let scale = CGAffineTransformMakeScale(0, 0)
        let translateTop = CGAffineTransformMakeTranslation(0, -500)
        let translateBottom = CGAffineTransformMakeTranslation(0, 500)
        facebookButton.transform = CGAffineTransformConcat(scale, translateBottom)
        twitterButton.transform = CGAffineTransformConcat(scale, translateTop)
        messagesButton.transform = CGAffineTransformConcat(scale, translateBottom)
        emailButton.transform = CGAffineTransformConcat(scale, translateTop)
    }
    
    override func viewDidAppear(animated: Bool) {
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
