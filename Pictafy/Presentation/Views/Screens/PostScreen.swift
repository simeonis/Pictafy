//
//  PostView.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-12-11.
//

import SwiftUI

struct PostScreen: View {
    var friend: Friend? = nil
    @State private var hideTag : Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("sample_post")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
            HStack {
                ProfileIcon(image: friend?.image ?? "profile_pic1", scale: 0.5)
                    .padding(8)
                Text(friend?.username ?? "Unknown").foregroundColor(.white)
                    .bold()
                    .font(.system(size: 24))
                    .lineLimit(1)
                Spacer()
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.ui.primaryColor,Color.ui.blue]), startPoint: .topLeading, endPoint: .bottomTrailing).opacity(0.9))
            .cornerRadius(16)
            .padding()
            .opacity(hideTag ? 0 : 1)
        } // VStack
        .edgesIgnoringSafeArea(.all)
        .onTapGesture(perform: {
            withAnimation(.easeInOut(duration: 0.6)) {
                hideTag.toggle()
            }
        })
    }
}

struct PostScreen_Previews: PreviewProvider {
    static var previews: some View {
        PostScreen(friend: nil)
    }
}

