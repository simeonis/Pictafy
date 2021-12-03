//
//  FirestoreController.swift
//  Pictafy
//
//  Created by Temari Uchiha on 2021-11-27.
//

import Foundation
import UIKit
import FirebaseFirestore

class FireStoreController: UIViewController {
    let database = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let docRef = database.document("pictafy-swift/accounts")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            print(data)
        }
    }
    
    func writeData(text: String) {
        let docRef = database.document("pictafy-swift/accounts")
        docRef.setData(["text":text])
    }
}
