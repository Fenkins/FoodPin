//
//  MapViewController.swift
//  FoodPin
//
//  Created by Fenkins on 06/05/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MKMapView!

    var restaurant:Restaurant!
    let annotation = MKPointAnnotation()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Showing user current location
        mapView.showsUserLocation = true
        mapView.delegate = self
        // Necessary settings
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
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
                
                println("Our desired coordinates is " + "\(self.annotation.coordinate.longitude)" + " " + "\(self.annotation.coordinate.latitude)")
                self.mapView.showAnnotations([self.annotation], animated: true)
                self.mapView.selectAnnotation(self.annotation, animated: true)
                
                self.getDirections(lat: placemark.location.coordinate.latitude, long: placemark.location.coordinate.longitude)
            }
        })
        
        
        

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
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
    }
    
    func getDirections(#lat:Double, long:Double) {
        
        let request = MKDirectionsRequest()
        
        let destCoord2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let destination = MKPlacemark(coordinate: destCoord2D, addressDictionary: nil)
        println("DESTINATION UNKNOWN" + "\(destCoord2D.latitude)")
        request.setSource(MKMapItem.mapItemForCurrentLocation())
        request.setDestination(MKMapItem(placemark: destination))
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler({(response:
            MKDirectionsResponse!, error: NSError!) in
            
            if error != nil {
                println("Error getting directions")
                println(error)
            } else {
                self.showRoute(response)
            }
            
        })
    }
    
    func showRoute(response: MKDirectionsResponse) {
        
        for route in response.routes as! [MKRoute] {
            
            mapView.addOverlay(route.polyline,
                level: MKOverlayLevel.AboveRoads)
            
            for step in route.steps {
                println(step.instructions)
            }
        }
        // We should check if the userLocation is not nil, otherwise we are gonna have an error and bad time
        if mapView.userLocation.location != nil {
            let userLocation = mapView.userLocation
            
            let region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 2000, 2000)
            mapView.setRegion(region, animated: true)
        }
        
        
        self.locationManager.stopUpdatingLocation()
        
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay
        overlay: MKOverlay!) -> MKOverlayRenderer! {
            let renderer = MKPolylineRenderer(overlay: overlay)
            
            renderer.strokeColor = UIColor.blueColor()
            renderer.lineWidth = 5.0
            return renderer
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
