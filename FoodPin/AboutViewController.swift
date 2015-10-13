//
//  AboutViewController.swift
//  FoodPin
//
//  Created by Fenkins on 25/05/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: UIViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {

    @IBAction func sendEmail(sender: AnyObject) {sendMailParam("support@appcoda.com")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func sendMailParam(sendTo:String) {
        if MFMailComposeViewController.canSendMail() {
            let composer = MFMailComposeViewController()
            
            composer.mailComposeDelegate = self
            composer.setToRecipients([sendTo])
            composer.navigationBar.tintColor = UIColor.whiteColor()
            
            presentViewController(composer, animated: true, completion: {
                UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
            })
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Mail cancelled")
        case MFMailComposeResultSaved.rawValue:
            print("Mail saved")
        case MFMailComposeResultSent.rawValue:
            print("Mail sent")
        case MFMailComposeResultFailed.rawValue:
            print("Failed to send email \(error!.localizedDescription)")
        default:
            break
        }
        //Dismiss the mail interface ITS IMPORTANT LINE - USER COULD NOT DISMISS CONTRLLER UNLESS IT IS HERE
        dismissViewControllerAnimated(true, completion: nil)
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
