//
//  PictureData.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-13.
//

import SwiftUI
import MapKit

//Codable?
struct PictureData: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
