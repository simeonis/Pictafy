//
//  PictafyApp.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-10-30.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class AppState: ObservableObject {
    static let shared = AppState()
    @Published var pageToNavigateTo : String?
}

@main
struct PictafyApp: App {
    
    let fireDBHelper : FireDBHelper
    
    init() {
        FirebaseApp.configure()
        fireDBHelper = FireDBHelper(database: Firestore.firestore())
      }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("isDarkMode") private var isDarkMode = false
    private let locationService = LocationService()
    
    var body: some Scene {
        WindowGroup {
            WelcomeScreen().environmentObject(fireDBHelper)
            .environmentObject(locationService)
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
