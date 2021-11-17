//
//  DarkModeToggleButton.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-17.
//

import SwiftUI

struct DarkModeToggleStyle: ToggleStyle {
    private let onImageName: String = "night"
    private let offImageName: String = "day"
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(configuration.isOn ? onImageName : offImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 51, height: 31, alignment: .center)
                .overlay(
                    Circle()
                        .foregroundColor(configuration.isOn ? .black : .white)
                        .padding(.all, 3)
                        .overlay(
                            Image(systemName: configuration.isOn ? "moon.fill" : "sun.max.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .font(Font.title.weight(.black))
                                .frame(width: 16, height: 16, alignment: .center)
                                .foregroundColor(configuration.isOn ? .white : .yellow)
                        )
                        .offset(x: configuration.isOn ? 11 : -11, y: 0)
                        .animation(Animation.linear(duration: 0.1))
                ).cornerRadius(20)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}
