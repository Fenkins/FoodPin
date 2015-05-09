//
//  MapViewController.swift
//  FoodPin
//
//  Created by Fenkins on 06/05/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!

    var restaurant:Restaurant!
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Convert adress to coordinate and annotate it to the map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: { placemarks, error in
            if error != nil {
                println(error)
                return
            }
            if placemarks != nil && placemarks.count > 0 {
                let placemark = placemarks[0] as! CLPlacemark
                
                // Add annotation
                self.annotation.title = self.restaurant.name
                self.annotation.subtitle = self.restaurant.type
                self.annotation.coordinate = placemark.location.coordinate
                self.mapView.showAnnotations([self.annotation], animated: true)
                self.mapView.selectAnnotation(self.annotation, animated: true)
            }
        })

        
        mapView.delegate = self
        
        // Route request
        let request = MKDirectionsRequest()
        let destination = MKPlacemark(coordinate: annotation.coordinate, addressDictionary: nil)
        request.setSource(MKMapItem.mapItemForCurrentLocation())
        request.setDestination(MKMapItem(placemark: destination))
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        directions.calculateDirectionsWithCompletionHandler({(response:MKDirectionsResponse!, error: NSError!) in
            if error != nil {
                // How to handle errors? I dunno
            } else {
                self.showRoute(response)
            }
        })
        
//        CLLocationManager.requestAlwaysAuthorization(<#CLLocationManager#>)
//        CLLocationManager.requestWhenInUseAuthorization(<#CLLocationManager#>)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let  identifier = "My Pin"
        
        if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        
        // Reuse the annotation if possible
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
        leftIconView.image = UIImage(named: restaurant.image)
        annotationView.leftCalloutAccessoryView = leftIconView
        
        return annotationView
    }
    
    func showRoute(response: MKDirectionsResponse) {
        
        for route in response.routes as! [MKRoute] {
            
            mapView.addOverlay(route.polyline,
                level: MKOverlayLevel.AboveRoads)
        }
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
