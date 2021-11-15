//
//  HomeView.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-10-30.
//

import SwiftUI

struct HomeScreen: View {
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
            CreatePostScreen()
            .tabItem {
                Label("Create Post", systemImage: "square.and.pencil")
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
