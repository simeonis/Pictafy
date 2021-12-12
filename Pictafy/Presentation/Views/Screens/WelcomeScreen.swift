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
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.ui.blue, Color.ui.primaryColor]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.vertical)
                Image("circle_art")
                    .resizable()
                    .frame(width: 1000, height: 1000, alignment: .center)
                    .padding(.leading,150)
                    .rotationEffect(.degrees(-10))
                
                VStack {
                    NavigationLink(destination: SignInScreen(), tag: 1, selection: $_selection) {}
                    NavigationLink(destination: SignUpScreen(), tag: 2, selection: $_selection) {}
                    NavigationLink(destination: HomeScreen(), tag: 3, selection: $_selection) {}
                    NavigationLink(destination: HomeScreen(), isActive: pushNavigationBinding) {}
                    
                    Image(systemName: "camera")
                        .foregroundColor(.white)
                        .font(.system(size: 100))
                        .padding(5)
                    
                    Text("Pictafy")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .textCase(.uppercase)
                        .font(.largeTitle)
                    
                    WelcomeButton(action: {_selection = 1}, text: "Log in")
                        .padding(.top,200)
                    
                    WelcomeButton(action: {_selection = 2}, text: "Sign up")
                    
                    //will be removed later
                    Button(action: { _selection = 3 }) {
                        Text("Home")
                            .foregroundColor(.blue)
                    }
                    .navigationBarHidden(true)
                }
            }
        } // NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.primary)
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
