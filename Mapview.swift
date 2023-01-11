//
//  Mapview.swift
//  oct
//
//  Created by Francisco Perez on 09/01/23.
//

import MapKit
import SwiftUI



struct Mapview: View {
    @StateObject private var viewModel =  ContentViewModel()
    
   
    
    var body: some View {
        //we add the $ mark because state var
        Map(coordinateRegion: $viewModel.region,showsUserLocation: true)
            .ignoresSafeArea()
            .onAppear{
                viewModel.checkiflocationmanageriseanbled()
            }
    }
}

struct Mapview_Previews: PreviewProvider {
    static var previews: some View {
        Mapview()
    }
}// end previews





// whats an NSObject
// with NSObject we can delegate so...
// we need to add the delegate,we add the CLLocationManagerDelegate
// so now,we can access to all delegate methods from the LocationManager

final class ContentViewModel:NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // we need to change to publish var
    // before @State private var
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516,longitude: -121.891054),span:MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    
    // its optionla because when can turn off the location services
    var locationManager: CLLocationManager?
    
    func checkiflocationmanageriseanbled(){
        if CLLocationManager.locationServicesEnabled(){
            
            // as son we create the locationmamnager we access the delegate
            // we access the locationmanagerdidchangeAuth
            // so we accesing the delegate method so its unnesesary the checkLocationAuth
            // so we need to add the delagte to the locationManager
            
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            //locationManager?.desiredAccuracy
       
            //checkLocationAuthorization()
        }
        else{
            print("Show thelocaiton")
        }
    } // end fucntion checkiflocationmanageriseanbled 
    
  private func checkLocationAuthorization(){
      
      
      
      
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus{
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("Denied")
        case .authorizedAlways:
            //print("Auth always")
            // add the new region
            region = MKCoordinateRegion(center:locationManager.location!.coordinate,span:MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
        case .authorizedWhenInUse:
            print("Auth when in use")
        
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
} // end final class
