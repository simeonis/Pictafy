//
//  PictafyApp.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-10-30.
//

import SwiftUI

@main
struct PictafyApp: App {
    
    let locationService = LocationService()
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
            .environmentObject(locationService)
        }
    }
}
