//
//  PictafyApp.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-10-30.
//

import SwiftUI

class AppState: ObservableObject {
    static let shared = AppState()
    @Published var pageToNavigateTo : String?
}

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
