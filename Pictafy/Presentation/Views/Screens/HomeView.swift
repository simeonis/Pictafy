//
//  HomeView.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-10-30.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        TabView {
            VStack{
                Text("Home")
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            MapScreen()
            .tabItem {
                Label("Map", systemImage: "map.fill")
            }
            CameraScreen()
            .tabItem {
                Label("Camera", systemImage: "camera.fill")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
