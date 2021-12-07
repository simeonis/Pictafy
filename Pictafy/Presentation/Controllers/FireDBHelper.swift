//
//  FireDBHelper.swift
//  Pictafy
//
//  Created by Temari Uchiha on 2021-12-03.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FireDBHelper: ObservableObject{
    @Published var accountList = [Account]()
    @Published var isAuth : Bool = false
    @Published var signUpSuccess : Bool = false
    private let COLLECTION_NAME : String = "Accounts"
    private let store : Firestore
    
    private static var shared : FireDBHelper?
    
    static func getInstance() -> FireDBHelper {
        if shared == nil{
            shared = FireDBHelper(database: Firestore.firestore())
        }
        return shared!
    }
    
    init(database : Firestore){
        self.store = database
        self.listen()
    }
    
    func insertAccount(newAccount: Account){
        do{
            try self.store.collection(COLLECTION_NAME).addDocument(from: newAccount)
        }catch let error as NSError{
            print(#function, "Error while inserting the Account", error)
        }
    }
    
    func listen(){
    
        Auth.auth().addStateDidChangeListener{ auth, user in
//            if user != nil {
//                print("user is here")
//                self.isAuth = true
//            }
//            else{
//                self.isAuth = false
//            }
            if let user = user {
                self.isAuth = true
            }
            else{
                self.isAuth = false
            }
        }
    
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password ){ authResult, error in
            print("Auth result = \(authResult)")

//            guard let strongSelf = self else {return}
//            if error != nil {
//                print(error)
//                print("error is good")
//                self.signUpSuccess = false
//                return
//            }
//            print("sign up success \(self.signUpSuccess)")
//            self.signUpSuccess = true
//            else{
//                print("Error is not nil")
//                self.signUpSuccess = false
//            }
        }
    }
    
    func createAccount(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password ){ authResult, error in
            print("Auth result = \(authResult)")
            if let error = error {
                print("Error when signing up: \(error)")
                return
            }
            else{
                print("NO Error when signing up!!!")
                self.signUpSuccess = true 
            }
            
        }
    }
    
    
//    func getAllAccounts(){
//            self.store.collection(COLLECTION_NAME)
//                .order(by: "dateCreated", descending: true)
//                .addSnapshotListener({(querySnapshot, error) in
//                    guard let snapshot = querySnapshot else{
//                        print(#function, "Error getting the snapshot of the documents", error)
//                        return
//                    }
//                    
//                    snapshot.documentChanges.forEach{ (docChange) in
//                        
//                        var account = Account()
//                        
//                        do{
//                            account = try docChange.document.data(as: Account.self)!
//                            
//                            if docChange.type == .added{
//                                self.accountList.append(account)
//                                print(#function, "New document added : ", account)
//                            }
//                            
//                            if docChange.type == .modified{
//                                let docId = docChange.document.documentID
//                                
//                                let matchedIndex = self.accountList.firstIndex(where: {($0.id?.elementsEqual(docId))!})
//                                if (matchedIndex != nil){
//                                    self.accountList[matchedIndex!] = account
//                                }
//                            }
//                            
//                            if docChange.type == .removed{
//                                let docId = docChange.document.documentID
//                                
//                                let matchedIndex = self.accountList.firstIndex(where: {($0.id?.elementsEqual(docId))!})
//                                if (matchedIndex != nil){
//                                    self.accountList.remove(at: matchedIndex!)
//                                }
//                            }
//                            
//                        }catch let error as NSError{
//                            print(#function, "error while gettting document change", error)
//                        }
//                    }
//                })
//    }
//    
//    func updateAccount(accountTobeUpdated: Account){
//        self.store.collection(COLLECTION_NAME).document(accountTobeUpdated.id!)
//            .updateData(["image" : accountTobeUpdated.image]){ error in
//                if let error = error{
//                    print(#function, "error while updating doc" , error)
//                }else{
//                    print(#function, "Document successfully updated")
//                }
//            }
//    }
//    
//    func deleteAccount(accountToDelete : Account){
//        self.store.collection(COLLECTION_NAME).document(accountToDelete.id!).delete{error in
//            if let error = error{
//                print(#function, "error while deleting doc " , error)
//            }else{
//                print(#function, "Document successfully deleted")
//            }
//        }
//    }
    
}

