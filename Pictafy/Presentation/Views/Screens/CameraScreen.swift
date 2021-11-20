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
    
    var body: some View {
        ZStack{
            Camera(events: cameraUserEvents)
            CameraInterfaceView(events: cameraUserEvents)
        }
    }
}

struct CameraScreen_Previews: PreviewProvider {
    static var previews: some View {
        CameraScreen()
    }
}
