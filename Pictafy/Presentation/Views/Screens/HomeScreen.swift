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
    
    @ObservedObject var appState = AppState.shared
    var pushNavigationBinding : Binding<Bool> {
        .init { () -> Bool in
            appState.pageToNavigateTo != nil
        } set: { (newValue) in
            if !newValue { appState.pageToNavigateTo = nil }
        }
    }
    
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
        TabView {
            // Home
            NavigationView{
                VStack{
                    NavigationLink(destination: SettingScreen(), tag: 1, selection: $_selection) {}
                    NavigationLink(destination: FriendScreen(), tag: 2, selection: $_selection) {}
                    NavigationLink(destination: SignInScreen(), tag: 3, selection: $_selection) {}
                    NavigationLink(destination: FriendRequests(), isActive: pushNavigationBinding) {}
                    
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
                Image(systemName: "house.fill")
            }

            MapScreen()
            .tag(Tab.map)
            .tabItem {
                Image(systemName: "map.fill")
            }
            NavigationView{
                CameraScreen()
            }
            .tag(Tab.camera)
            .tabItem {
                Image(systemName: "camera.fill")
            }
        } // TabView
        .environmentObject(tabController)
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
