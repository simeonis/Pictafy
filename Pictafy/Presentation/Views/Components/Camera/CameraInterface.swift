//
//  CameraInterface.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-20.
//

import SwiftUI

struct CameraInterfaceView: View, CameraActions {

    @ObservedObject var events: CameraUserEvents
    
    var imageT: Binding<UIImage?>
    
    public init(events: CameraUserEvents, image: Binding<UIImage?>){
        self.events = events
        self.imageT = image
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack{
                if(imageT.wrappedValue != nil){
                    Image(uiImage: imageT.wrappedValue!)
                    .resizable()
                    .frame(width: 75, height: 75)
                }
                else{
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 75, height: 75)
                }
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.2))

                    Circle()
                        .strokeBorder(Color.white, lineWidth: 2)
                }
                .frame(width: 75, height: 75)
                .onTapGesture {
                    self.takePhoto(events: events)
                }
                Spacer()
                
            }
           
        }
    }
}
