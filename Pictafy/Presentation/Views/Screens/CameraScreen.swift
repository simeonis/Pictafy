//
//  CameraScreen.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-13.
//

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
    }
}

struct CameraScreen_Previews: PreviewProvider {
    static var previews: some View {
        CameraScreen()
    }
}
