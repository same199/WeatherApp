//
//  ViewController.swift
//  WeatherApp
//
//  Created by LizOk&Same on 31.01.26.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        

            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        
        }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = manager.location?.coordinate else { return }
        print("широта:\(location.latitude), долгота: \(location.longitude)")
        
    }
    
    func configureUI(){
        view.backgroundColor = .red
    }
    


}

