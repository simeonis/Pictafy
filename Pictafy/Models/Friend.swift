//
//  Friend.swift
//  Pictafy
//
//  Created by Shae Simeoni on 2021-11-30.
//  Group - 2: Shae Simeoni: zpa9, Rita Singh: 991573398, Seth Climenhaga: 991599894

import SwiftUI

// Temporary Data Structure
struct Friend : Hashable, Identifiable {
    let id: UUID = UUID()
    var username : String = ""
    var fullname : String = ""
    var image : String = ""
}
