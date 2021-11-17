//
//  PictafyApp.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-10-30.
//

import SwiftUI

@main
struct PictafyApp: App {
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
