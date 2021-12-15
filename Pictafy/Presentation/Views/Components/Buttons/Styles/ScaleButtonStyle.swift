//
//  ScaleButton.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-17.
//  Group - 2: Shae Simeoni: zpa9, Rita Singh: 991573398, Seth Climenhaga: 991599894

import SwiftUI

struct ScaleButtonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
