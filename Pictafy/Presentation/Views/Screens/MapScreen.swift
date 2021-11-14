//
//  MapScreen.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-13.
//

import SwiftUI
import MapKit


let pictures = [
    PictureData(name: "Sheridan", description: "here's a photo I took", latitude: 43.46921422071481, longitude: -79.69997672872174),
]


struct MapScreen: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude:   43.46921422071481,
            longitude: -79.69997672872174
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.075,
            longitudeDelta: 0.075
        )
    )
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: pictures){ pictureData in
            MapAnnotation(coordinate: pictureData.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                Label("", systemImage: "camera.fill")
            }
        }
    }
}
