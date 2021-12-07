//
//  HomeView.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-10-30.
//

import SwiftUI

struct HomeScreen: View {
    @State private var _selection: Int? = nil
    
    var body: some View {
        VStack {
            NavigationLink(destination: SettingScreen(), tag: 1, selection: $_selection) {}
            NavigationLink(destination: FriendScreen(), tag: 2, selection: $_selection) {}
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
            } // TabView
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing:
                HStack {
                    // Friend List Button
                    Button(action: { self._selection = 2 }) {
                        Image(systemName: "person.2")
                    }
                    
                    // User Settings Button
                    Button(action: { self._selection = 1 }) {
                        Image(systemName: "gearshape.fill")
                    }
                })
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
