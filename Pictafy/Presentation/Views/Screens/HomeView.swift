//
//  HomeView.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-10-30.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var cameraUserEvents = CameraUserEvents()
    
    var body: some View {
        CameraView(events: cameraUserEvents);
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
