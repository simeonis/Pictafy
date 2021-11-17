//
//  ScaleButton.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-17.
//

import SwiftUI

struct ScaleButtonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
