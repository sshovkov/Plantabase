//
//  DetailViewController.swift
//  Plantabase
//
//  Created by Shovkovy on 4/12/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import UIKit
import MapKit
import Contacts


class DetailViewController: UIViewController {
    
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    var selectedItem:item?
    var addressString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemName.text = selectedItem?.itemName
        websiteButton.layer.cornerRadius = 25
        phone.text = selectedItem?.itemPhoneNum
        // get the coordinates of the selected item
        let lat = selectedItem?.itemLat
        let lon = selectedItem?.itemLon
    
        // reverse geocoding
        convertLatLongToAddress(latitude: lat!, longitude: lon!)
    }
    
    
    // Reverse geocoding using the selected item's coordinates
    func convertLatLongToAddress(latitude:CLLocationDegrees,longitude:CLLocationDegrees){

        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in

            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]

            // Door number
            if let doorNumber = placeMark.subThoroughfare {
                self.address.text = self.address.text! + "\(doorNumber) "
            }
            // Street address
            if let street = placeMark.thoroughfare {
                self.address.text = self.address.text! + "\(street), "
            }
            // City
            if let city = placeMark.locality {
                self.address.text = self.address.text! + "\(city), "
            }
            //state
            if let state = placeMark.administrativeArea{
                self.address.text = self.address.text! + "\(state) "
            }
            // Zip code
            if let zip = placeMark.postalCode {
                self.address.text = self.address.text! + "\(zip) "
            }
            // Country
            if let country = placeMark.country {
                self.address.text = self.address.text! + "\(country)"
            }
        })

    }
    
    @IBAction func goToWebsiteButton(_ sender: UIButton) {
        if let url = selectedItem?.itemURL {
            UIApplication.shared.open(url)
        }
        else {
            let url = URL(string: "https://www.google.com")
            UIApplication.shared.open(url!)
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
