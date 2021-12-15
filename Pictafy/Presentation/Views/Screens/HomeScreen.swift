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
    @StateObject private var tabController = TabController()
    @State private var _selection: Int? = nil
    @State private var nearbyPosts: [Post] = []
    @State private var friendPosts: [Post] = []
    
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
            TabView {
                // Home
                NavigationView{
                    VStack{
                        
                        NavigationLink(destination: SettingScreen(), tag: 1, selection: $_selection) {}
                        NavigationLink(destination: FriendScreen(), tag: 2, selection: $_selection) {}
                        NavigationLink(destination: SignInScreen(), tag: 3, selection: $_selection) {}
//                        NavigationLink(destination: MapScreen(), tag: 4, selection: $_selection) {}
//                        NavigationLink(destination: CameraScreen(), tag: 5, selection: $_selection) {}
                        
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 0) {
                                PostRow(title: "Post Near Me", posts: fireDBHelper.nearbyPosts)
                                PostRow(title: "Friend's Posts", posts: friendPosts)
                            }
                        }
                        
                    }
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
                .tag(Tab.home)
                .tabItem {
                   VStack{
                       Image(systemName: "house.fill")
                       Text("Home")
                   }
                }

                MapScreen()
                .tag(Tab.map)
                .tabItem {
                   Label("Map", systemImage: "map.fill")
                }
                CameraScreen()
                .tag(Tab.camera)
                .tabItem {
                   Label("Camera", systemImage: "camera.fill")
                }
            } // TabView
            .environmentObject(tabController)
        }//VStack
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

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen().environmentObject(LocationService())
    }
}
