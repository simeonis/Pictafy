//
//  HomeView.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-10-30.
//

import SwiftUI
import MapKit

struct HomeScreen: View {
    @EnvironmentObject var locationService : LocationService
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State private var _selection: Int? = nil
    @State private var nearbyPosts: [Post] = []
    @State private var friendPosts: [Post] = []
    
    private var posts = [
        Friend(username: "Richard", fullname: "Richard Smith", image: "profile_pic1"),
        Friend(username: "Richard", fullname: "Richard Smith", image: "profile_pic1"),
        Friend(username: "Richard", fullname: "Richard Smith", image: "profile_pic1"),
        Friend(username: "Richard", fullname: "Richard Smith", image: "profile_pic1"),
        Friend(username: "Richard", fullname: "Richard Smith", image: "profile_pic1")
    ]
    
    private var posts2 = [
        Friend(username: "Richard", fullname: "Richard Smith", image: "profile_pic1")
    ]
    
    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.systemBackground
        UITableViewCell.appearance().backgroundColor = UIColor.clear
    }
    
    func loadData() {
        fireDBHelper.getFriendsPost() { posts in
            friendPosts = posts
        }
        
        self.locationService.checkPermission()
        
        if(locationService.currentLocation != nil){
            self.fireDBHelper.geoQuery(center: CLLocationCoordinate2D(
                                                latitude: locationService.currentLocation!.coordinate.latitude,
                                                longitude: locationService.currentLocation!.coordinate.longitude))
        }
    }
    
    var body: some View {
        VStack {
            NavigationLink(destination: SettingScreen(), tag: 1, selection: $_selection) {}
            NavigationLink(destination: FriendScreen(), tag: 2, selection: $_selection) {}
            TabView {
                // Content
                VStack {
                    if (posts.count > 0 ) {
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 0) {
                                PostRow(title: "Post Near Me", posts: fireDBHelper.nearbyPosts)
                                PostRow(title: "Friend's Posts", posts: friendPosts)
                            }
                        }
                    } else {
                        Text("Something went wrong")
                    }
                }
                // Tab buttons
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
            .onAppear() { loadData() }
            .onReceive(fireDBHelper.$isAuth) { success in
                if !success {
                    print("Invalid Authorization, Aborting!")
                    self._selection = 3
                } else {
                    print("Successful Authorization, Welcome!")
                }
            }
        }
        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen().environmentObject(LocationService())
    }
}
