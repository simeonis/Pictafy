//
//  CameraScreen.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-13.
//  Group - 2: Shae Simeoni: 991625152, Rita Singh: 991573398, Seth Climenhaga: 991599894

import Foundation
import SwiftUI

struct CameraScreen: View {
    
    @StateObject var cameraUserEvents = CameraUserEvents()
    
    @State var image : UIImage? = nil
    
    var body: some View {
    
            ZStack{
                Camera(events: cameraUserEvents, image: $image)
                CameraInterfaceView(events: cameraUserEvents, image: $image)
            }
            .background(Color.white)
            //.navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
    }
}

struct CameraScreen_Previews: PreviewProvider {
    static var previews: some View {
        CameraScreen()
    }
}
