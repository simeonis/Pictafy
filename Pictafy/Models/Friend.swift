//
//  Friend.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-30.
//

import SwiftUI

// Temporary Data Structure
struct Friend : Hashable, Identifiable {
    let id: UUID = UUID()
    var username : String = ""
    var fullname : String = ""
    var image : String = ""
}
