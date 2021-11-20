//
//  PostData.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-13.
//

import SwiftUI
import MapKit

//Codable?
struct PostData: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    var coordinate: CLLocationCoordinate2D
    
    init(name : String, description : String, coordinate : CLLocationCoordinate2D){
        self.name = name
        self.description = description
        self.coordinate = coordinate
    }
}
