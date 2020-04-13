//
//  MapViewController.swift
//  Plantabase
//
//  Created by Shovkovy on 3/21/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

// view controller for map view where user can search for plant nurseries

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var mapType: UISegmentedControl!
    @IBOutlet weak var map: MKMapView!
    
    let manager: CLLocationManager = CLLocationManager()
    let homeCoordinates = CLLocationCoordinate2D(latitude: 33.451350, longitude: -111.965550)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.layer.cornerRadius = 15
        
        let addressString = "5302 E Van Buren St, Phoenix, AZ 85008"
        CLGeocoder().geocodeAddressString(addressString, completionHandler: {
            (placemarks, error) in
            if error != nil{
                print("Geocode failed: \(error!.localizedDescription)")
            } else if placemarks!.count > 0 {
                let placemark = placemarks![0]
                let lat = placemark.location?.coordinate.latitude
                let lon = placemark.location?.coordinate.longitude
                self.displayMap(latInput: lat ?? 0, lonInput: lon ?? 0)
            }
        })
        // Do any additional setup after loading the view.
    }
    
    
    
    func displayMap (latInput: CLLocationDegrees, lonInput: CLLocationDegrees) {
        // display the map
        let lat : CLLocationDegrees = latInput
        let lon : CLLocationDegrees = lonInput
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region: MKCoordinateRegion = MKCoordinateRegion.init(center: coordinates, span: span)
        self.map.setRegion(region, animated: true)

        // add an annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = "Tempe"
        annotation.subtitle = "AZ"
        self.map.addAnnotation(annotation)
    }
    
    @IBAction func showMap(_ sender: Any) {
        switch(mapType.selectedSegmentIndex) {
        case 0:
            map.mapType = MKMapType.standard
        case 1:
            map.mapType = MKMapType.satellite
        case 2:
            map.mapType = MKMapType.hybrid
        default:
            map.mapType = MKMapType.standard
        }
    }
    
    @IBAction func search(_ sender: UIButton) {
        // remove existing annotations to update map only with what is being searched
        map.removeAnnotations(map.annotations)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.searchField.text //"Plant Stand of Arizona"
        request.region = map.region
        let search = MKLocalSearch(request: request)
        
        search.start {
            response, _ in guard let response = response else { return }
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            self.createAnnotations(matchingItems: matchingItems)
        }
        
        let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.15, longitudeDelta: 0.15)
        let region: MKCoordinateRegion = MKCoordinateRegion.init(center: homeCoordinates, span: span)
        self.map.setRegion(region, animated: true)
    }
    
    func createAnnotations (matchingItems: [MKMapItem]) {
        // for every item in the matchingItems array, create an annotation pin
        for i in 0...matchingItems.count - 1 {
            let place = matchingItems[i].placemark
            let lat : CLLocationDegrees = (place.location?.coordinate.latitude)!
            let lon : CLLocationDegrees = (place.location?.coordinate.longitude)!
            let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
            // add an annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = place.name
            self.map.addAnnotation(annotation)
        }
    }
    
    class func isLocationServiceEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            default:
                print("Something wrong with Location services")
                return false
            }
        } else {
            print("Location services are not enabled")
            return false
        }
    }
    
    // This goes inside of viewDidLoad
    //        manager.delegate = self
    //        manager.desiredAccuracy = kCLLocationAccuracyBest
    //        manager.requestWhenInUseAuthorization()
    //        manager.startUpdatingLocation()
    
    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //        let location = locations[0]
    //        let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.02, longitudeDelta: 0.02)
    //        let myLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    //        let region: MKCoordinateRegion = MKCoordinateRegion.init(center: myLocation, span: span)
    //        map.setRegion(region, animated: true)
    //        self.map.showsUserLocation = true
    //    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
