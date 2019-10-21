//
//  DetailVC.swift
//  WeatherGift
//
//  Created by Richard Jove on 10/9/19.
//  Copyright © 2019 Richard Jove. All rights reserved.
// Richard

import UIKit
import CoreLocation

class DetailVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    
    var currentPage = 0
    var locationsArray = [WeatherLocation]()
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationLabel.text = locationsArray[currentPage].name
        dateLabel.text = locationsArray[currentPage].coordinates
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if currentPage == 0 {
            getLocation()
        }
    }
}

extension DetailVC: CLLocationManagerDelegate {
    
    func getLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self //Can't do this in viewDidLoad until create location manager
        let status = CLLocationManager.authorizationStatus()
        handleLocationAuthorizationStatus(status: status)
        
    }
    
    func handleLocationAuthorizationStatus(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied:
            print("Sorry, we cannot show the location because the user has not authorized it.")
        case .restricted:
            print("Access denied. Likely parental controls are restricting location services in this app.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleLocationAuthorizationStatus(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        let currentLatitude = currentLocation.coordinate.latitude
        let currentLongitude = currentLocation.coordinate.longitude
        let currentCoordinates = "\(currentLatitude), \(currentLongitude)"
        print(currentCoordinates)
        dateLabel.text = currentCoordinates
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location.")
    }
    
}
