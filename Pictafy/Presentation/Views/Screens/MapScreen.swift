//
//  MapScreen.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-13.
//

import SwiftUI
import MapKit

struct MapScreen: View {

    @EnvironmentObject var locationService : LocationService
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State var posts = [Post]()

    var body: some View {
        Map(coordinateRegion: $locationService.region, annotationItems: posts){ postData in
            MapAnnotation(coordinate: CLLocationCoordinate2DMake(postData.latitude, postData.longitude), anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                ZStack{
                    Circle()
                        .fill(Color.blue)
                        .frame(width:50, height: 25)

                    Image(systemName: "camera.circle.fill")
                        .foregroundColor(.white)
                        .frame(width:45, height: 20)
                }
            }
        }
        .onAppear(){
            self.locationService.checkPermission()
            
            if(locationService.currentLocation != nil){
                self.fireDBHelper.geoQuery(center: CLLocationCoordinate2D(
                    latitude: locationService.currentLocation!.coordinate.latitude,
                    longitude: locationService.currentLocation!.coordinate.longitude)
                )
            }
        }
        .navigationBarHidden(true)
        .onReceive(fireDBHelper.$nearbyPosts){nPosts in
            self.posts = nPosts
        }
    }
}
