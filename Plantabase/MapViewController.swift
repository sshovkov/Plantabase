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

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var mapType: UISegmentedControl!
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var itemsTable: UITableView!
    
    let manager: CLLocationManager = CLLocationManager()
    let homeCoordinates = CLLocationCoordinate2D(latitude: 33.451350, longitude: -111.965550)
    var myItemList:items = items()
    
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
        
//        // uncomment when doing user location (doesn't work well with testing app on laptop, only iPhone)
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.requestWhenInUseAuthorization()
//        manager.startUpdatingLocation()
        
        // Do any additional setup after loading the view.
    }
    
//    // uncomment when doing user location (doesn't work well with testing app on laptop, only iPhone)
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            manager.stopUpdatingLocation()
//
//            render(location)
//        }
//    }
    
//    // uncomment when doing user location (doesn't work well with testing app on laptop, only iPhone)
//    func render(_ location: CLLocation) {
//        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        let region = MKCoordinateRegion(center: coordinate, span: span)
//
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = coordinate
//        self.map.addAnnotation(annotation)
//
//        map.setRegion(region, animated: true)
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
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
        // clear all items from any previous searches
        self.myItemList.items.removeAll()
        itemsTable.reloadData()
        
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
        var theURL = URL(string: "https://www.google.com")
        // for every item in the matchingItems array, create an annotation pin
        for i in 0...matchingItems.count - 1 {
            let place = matchingItems[i].placemark
            let phoneNumber = String(matchingItems[i].phoneNumber!)
            
            if matchingItems[i].url != nil {
                theURL = matchingItems[i].url
            } 
            
            let lat : CLLocationDegrees = (place.location?.coordinate.latitude)!
            let lon : CLLocationDegrees = (place.location?.coordinate.longitude)!
            let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
            // add an annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = place.name
            self.map.addAnnotation(annotation)
            
            // add all the results from the annotations to the items array
            let f4 = item(itName: place.name!, itLat: lat, itLon: lon, phoNum: phoneNumber, itURL: theURL!)
            self.myItemList.items.append(f4)
            let indexPath = IndexPath (row: self.myItemList.items.count - 1, section: 0)
            self.itemsTable.beginUpdates()
            self.itemsTable.insertRows(at: [indexPath], with: .automatic)
            self.itemsTable.endUpdates()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItemList.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
        cell.layer.borderWidth = 0.5
        cell.itemTitle.text = myItemList.items[indexPath.row].itemName
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.itemsTable.indexPath(for: sender as! UITableViewCell)!
        let item = myItemList.items[selectedIndex.row]
        
        if (segue.identifier == "toDetailViewController"){
            if let viewController: DetailViewController = segue.destination as? DetailViewController {
                viewController.selectedItem = item
            }
        }
    }
    
//    class func isLocationServiceEnabled() -> Bool {
//        if CLLocationManager.locationServicesEnabled() {
//            switch(CLLocationManager.authorizationStatus()) {
//            case .notDetermined, .restricted, .denied:
//                return false
//            case .authorizedAlways, .authorizedWhenInUse:
//                return true
//            default:
//                print("Something wrong with Location services")
//                return false
//            }
//        } else {
//            print("Location services are not enabled")
//            return false
//        }
//    }
    
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
