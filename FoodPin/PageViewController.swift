//
//  PageViewController.swift
//  FoodPin
//
//  Created by Fenkins on 22/05/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var pageHeadings = ["Personalize","Locate","Discover"]
    var pageImages = ["homei","mapintro","fiveleaves"]
    var pageSubHeadings = ["Pin your favourite restaurants and create your own food guide", "Search and locate your favourite restaurant on Maps","Find restaurants pinned by your friends and other foodies around the world"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the dataSource to self
        dataSource = self
        
        // Create the first walktrough screen 
        if let startingViewController = self.viewControllerAtIndex(0) {
            setViewControllers([startingViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        // We get the current page index of the given view controller. Depending the method, we simply increase/decrease the index number and return the view controller to display.
        var index = (viewController as! PageContentViewController).index
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        // We get the current page index of the given view controller. Depending the method, we simply increase/decrease the index number and return the view controller to display.
        var index = (viewController as! PageContentViewController).index
        index++
        return self.viewControllerAtIndex(index)
    }
    
    func forward(index:Int) {
        // If viewController could be created, we navigate using setViewControllers
        if let nextViewController = self.viewControllerAtIndex(index + 1) {
            setViewControllers([nextViewController], direction: .Forward, animated: true, completion: nil)
        }
    }
    
    
    
    func viewControllerAtIndex(index: Int) -> PageContentViewController? {
        if index == NSNotFound || index < 0 || index >= self.pageHeadings.count {
            return nil
        }
        
        // Create view controller and pass suitable data.
        if let pageContentViewController  = storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as? PageContentViewController {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        return nil
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
