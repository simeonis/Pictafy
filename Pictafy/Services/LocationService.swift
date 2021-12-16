//
//  LocationService.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-13.
//  Group - 2: Shae Simeoni: 991625152, Rita Singh: 991573398, Seth Climenhaga: 991599894

import Foundation
import CoreLocation
import MapKit
import SwiftUI

class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    // MARK: Vars
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    //@Published var address : String = "unknown"
    @Published var currentLocation: CLLocation?
    
    @Published var region : MKCoordinateRegion =  MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude:   43.46921422071481,
            longitude: -79.69997672872174
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.075,
            longitudeDelta: 0.075
        )
    )

    private let locationManager = CLLocationManager()
    private var lastSeenLocation: CLLocation?
    
    ///-tag: Attach to this in any backend code to receive location
    var onGetLocation: ((_ location: CLLocationCoordinate2D )->())?
    
    // MARK: Constructors
    override init() {
        super.init()
        
        if (CLLocationManager.locationServicesEnabled()){
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        self.checkPermission()
        
        if (CLLocationManager.locationServicesEnabled() && ( self.authorizationStatus == .authorizedAlways || self.authorizationStatus == .authorizedWhenInUse)){
            self.locationManager.startUpdatingLocation()
        }else{
            self.requestPermission()
        }
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: Permissions
    // Move to common permissions manager?
    func requestPermission() {
        if (CLLocationManager.locationServicesEnabled()){
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func checkPermission(){
        print(#function, "Checking for permission")
        switch self.locationManager.authorizationStatus {
        case .denied:
            self.requestPermission()
        case .notDetermined:
            self.requestPermission()
        case .restricted:
            self.requestPermission()
        case .authorizedAlways:
            self.locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    func shouldStartUpdatingLocation(){
        switch self.locationManager.authorizationStatus {
        case .authorizedAlways:
            self.locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "Authorization Status : \(manager.authorizationStatus.rawValue)")
        self.authorizationStatus = manager.authorizationStatus
        
        self.shouldStartUpdatingLocation()
    }
    
    // MARK: Manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.lastSeenLocation = locations.first
        print(#function, "last seen location: \(self.lastSeenLocation!)")
        
        if locations.last != nil{
            self.currentLocation = locations.last!
        }else{
            self.currentLocation = locations.first
        }
        
        if(self.currentLocation != nil){
             onGetLocation?(self.currentLocation!.coordinate)
        }
     
        self.region =  MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude:   self.currentLocation!.coordinate.latitude,
                longitude: self.currentLocation!.coordinate.longitude
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.075,
                longitudeDelta: 0.075
            )
        )

        print(#function, "current location: \(self.currentLocation!)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, "error: \(error.localizedDescription)")
    }
    
}
    
