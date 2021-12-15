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
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        fireDBHelper = FireDBHelper(database: Firestore.firestore())
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("isDarkMode") private var isDarkMode = false
    private let locationService = LocationService()
    
    @State var showHome = false
    @State var isSignedIn = false
    
    var body: some Scene {
        WindowGroup {
            VStack{
                if(self.showHome && self.isSignedIn){
                    HomeScreen()
                
                }
                else{
                    WelcomeScreen()
                }
                
            }
            .environmentObject(fireDBHelper)
            .environmentObject(locationService)
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .onReceive(fireDBHelper.$isAuth){ auth in
                self.showHome = auth
            }
            .onReceive(fireDBHelper.$signedIn){ s in
                self.isSignedIn = s
            }
            
          

        }
        
    }
}
