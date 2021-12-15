//
//  Loader.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-12-14.
//

import Foundation
import SwiftUI
import Combine
import FirebaseStorage

final class Loader : ObservableObject {
    
    var image : UIImage? = nil {
        willSet {
            objectWillChange.send()
        }
    }
    
    init(_ path: String){
        let url = "\(path).jpg"
        let storage = Storage.storage()
        let ref = storage.reference().child(url)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Loader: \(error)")
            }

            DispatchQueue.main.async {
                if(data != nil){
                    self.image = UIImage(data: data!)
                }
            }
        }
    }
}
