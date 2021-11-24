//
//  PictafyApp.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-10-30.
//

import SwiftUI
import Firebase

@main
struct PictafyApp: App {
    
     @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    private let locationService = LocationService()
    
    var body: some Scene {
        WindowGroup {
            WelcomeScreen()
            .environmentObject(locationService)
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
