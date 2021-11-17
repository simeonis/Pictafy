//
//  WelcomeScreen.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-17.
//

import SwiftUI

struct WelcomeScreen: View {
    @State private var _selection: Int? = nil
    @AppStorage("isDarkMode") var isDarkMode : Bool = false
    
    init() {
        // Transparent NavBar
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: HomeScreen(), tag: 1, selection: $_selection) {}
                Button(action: { _selection = 1 }) {
                    Text("Go To Home Screen")
                        .foregroundColor(.blue)
                }
                .navigationBarHidden(true)
            }
        } // NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(isDarkMode ? .white : .black)
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
