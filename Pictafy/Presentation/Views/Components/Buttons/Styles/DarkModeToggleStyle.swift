//
//  DarkModeToggleButton.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-17.
//  Group - 2: Shae Simeoni: 991625152, Rita Singh: 991573398, Seth Climenhaga: 991599894

import SwiftUI

struct DarkModeToggleStyle: ToggleStyle {
    private let onImageName: String = "night"
    private let offImageName: String = "day"
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Rectangle()
                .foregroundColor(configuration.isOn ? .green : Color(red: 233/255, green: 233/255, blue: 234/255))
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
