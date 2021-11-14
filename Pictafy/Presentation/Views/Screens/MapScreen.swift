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
    
    @EnvironmentObject var locationService : LocationService

    var body: some View {
        Map(coordinateRegion: $locationService.region, annotationItems: pictures){ pictureData in
            MapAnnotation(coordinate: pictureData.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                ZStack{
                    Circle()
                        .fill(Color.blue)
                        .frame(width:50, height: 25)

                    Circle()
                        .fill(Color.white)
                        .frame(width:45, height: 20)
                }
            }
        }
        .onAppear(){
            self.locationService.checkPermission()
        }
    }
}
