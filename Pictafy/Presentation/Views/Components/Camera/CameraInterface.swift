//
//  CameraInterface.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-20.
//  Group - 2: Shae Simeoni: 991625152, Rita Singh: 991573398, Seth Climenhaga: 991599894

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
            ZStack{
                HStack{
                    if(imageT.wrappedValue != nil){
                        NavigationLink(destination: CreatePostScreen(image: imageT.wrappedValue!))
                        {
                            Image(uiImage: imageT.wrappedValue!)
                            .resizable()
                            .frame(width: 75, height: 75)
                        }
                        .padding(.leading, 10)
                    }
                    Spacer()
                }
                HStack{
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.2))

                        Circle()
                            .strokeBorder(Color.white.opacity(0.6), lineWidth: 2)
                    }
                    .frame(width: 75, height: 75)
                    .onTapGesture {
                        self.takePhoto(events: events)
                    }
                    Spacer()
                    
                }
            }
           
        }
        .padding(.bottom, 30)
    }
}
