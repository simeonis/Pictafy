//
//  FirebaseImage.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-12-14.
//
//
import Foundation
import SwiftUI
import FirebaseStorage


let placeholder = UIImage(named: "sample_post")!

struct FirebaseImage : View {

    @ObservedObject private var imageLoader : Loader
    private let modifiers: (Image) -> Image

    private var image : UIImage? = nil

    init(path: String, modifiers: @escaping (Image) -> Image = { $0 }) {
        self.imageLoader = Loader(path)
        self.modifiers = modifiers
    }

    var body: some View {
        modifiers(Image(uiImage: imageLoader.image ?? placeholder))
    }
}

