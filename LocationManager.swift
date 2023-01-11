//
//  LocationManager.swift
//  oct
//
//  Created by Francisco Perez on 09/01/23.
//

import CoreLocation
// whats a NSObject
//Answer: we can add delegates

class LocationManager: NSObject,ObservableObject{
    
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    
    static let shared = LocationManager()
    
    
    override init(){
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        
    }
    
    func requestLocation(){
        manager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status{
        case .notDetermined:
            print("Not determined")
        case .restricted:
            print("restricted")
        case .denied:
            print("Denied")
        case .authorizedAlways:
            print("Auth always")
        case .authorizedWhenInUse:
            print("Auth when in use")
        
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userLocation = location
    }
    }// end extesnion
    

