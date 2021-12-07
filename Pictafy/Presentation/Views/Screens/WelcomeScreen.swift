//
//  WelcomeScreen.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-17.
//

import SwiftUI

struct WelcomeScreen: View {
    @ObservedObject var appState = AppState.shared
    @State private var _selection: Int? = nil
    
    var pushNavigationBinding : Binding<Bool> {
        .init { () -> Bool in
            appState.pageToNavigateTo != nil
        } set: { (newValue) in
            if !newValue { appState.pageToNavigateTo = nil }
        }
    }
    
    init() {
        // Transparent NavBar
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(.blue)]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: HomeScreen(), tag: 1, selection: $_selection) {}
                // Push Notification Post
                NavigationLink(destination: FriendScreen(), isActive: pushNavigationBinding) {}
                Button(action: { _selection = 1 }) {
                    Text("Go To Home Screen")
                        .foregroundColor(.blue)
                }
                .navigationBarHidden(true)
            }
        } // NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
