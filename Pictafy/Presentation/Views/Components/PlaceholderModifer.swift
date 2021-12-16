//
//  PlaceholderModifer.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-11-25.
//  Group - 2: Shae Simeoni: 991625152, Rita Singh: 991573398, Seth Climenhaga: 991599894

import SwiftUI

public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                .padding(.horizontal, 5)
            }
            content
                .foregroundColor(Color.white)
            .padding(5.0)
        }
    }
}
