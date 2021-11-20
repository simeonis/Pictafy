//
//  CameraInterface.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-20.
//

import SwiftUI

struct CameraInterfaceView: View, CameraActions {
    @ObservedObject var events: CameraUserEvents
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .fill(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.2))

                Circle()
                    .strokeBorder(Color.white, lineWidth: 2)
            }
            .frame(width: 100, height: 100)
            .onTapGesture {
                self.takePhoto(events: events)
            }
    }
    }
}
