//
//  FireDBHelper.swift
//  Pictafy
//
//  Created by Temari Uchiha on 2021-12-03.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Firebase
import FirebaseStorage
import UIKit
import CoreLocation
import GeoFire
import SwiftUI


class FireDBHelper: ObservableObject {
    @Published var accountList = [Account]()
    @Published var isAuth : Bool = false
    @Published var signUpSuccess : Bool = false
    @Published var signedIn : Bool = false
    @Published var nearbyPosts = [Post]()
    @Published var account : Account? = nil
    
    private let COLLECTION_ACCOUNT : String = "Accounts"
    private let COLLECTION_POST : String = "Posts"
    private let store : Firestore
    private let auth = Auth.auth()
    private let storage = Storage.storage()
    
    private static var shared : FireDBHelper?
    
    var handle: AuthStateDidChangeListenerHandle?
    
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
        do {
            try self.store.collection(COLLECTION_ACCOUNT).addDocument(from: newAccount)
        }catch let error as NSError{
            print(#function, "Error while inserting the Account", error)
        }
    }
    
    func listen(){
        print("Listen Called")
        Auth.auth().addStateDidChangeListener {[weak self] (auth, user) in
            var state = false;
            
            if(user != nil)
            {
                state = true
                print("State true")
            }
            else{
                state = false
                print("State false")
            }
            
            self?.isAuth = state
           
        }
    }
        
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password ){ authResult, error in

            //guard let strongSelf = self else {return}
            
            if error != nil {
                print("error in sign in")
                self.signedIn = false
                return
            }
            else{
                print("Sign in OK")
                self.signedIn = true
            }
        }
    }
    
    func createAccount(email: String, password: String, completion: @escaping (Bool) -> Void){
        Auth.auth().createUser(withEmail: email, password: password ) {[weak self] authResult, error in
            if let error = error {
                print("Error when signing up: \(error)")
                completion(false)
            }
            else{
                completion(true)
                self?.signUpSuccess = true
            }
            
        }
    }
    
    func logout(){
        print("Logout called")
        do{
           try Auth.auth().signOut()
            self.signedIn = false
            
        }catch let error as NSError{
            print(#function, "Error while inserting the Account", error)
        }
    }
    
    func getCurrentAccount(completion: @escaping (Account) -> Void) {
        let user = Auth.auth().currentUser
        let ref = store.collection(COLLECTION_ACCOUNT).whereField("email", isEqualTo: user?.email ?? "")
        
        ref.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting document(s): \(err)")
                completion(Account())
            } else {
                let document = querySnapshot!.documents.first
                if (document != nil) {
                    completion(Account(id: document!.documentID, dictionary: document!.data()))
                    //self.account = Account(id: document!.documentID, dictionary: document!.data())
                }
            }
        }
    }
    
    func getAccount(completion: @escaping (Account) -> Void) {
        let user = Auth.auth().currentUser
        let ref = store.collection(COLLECTION_ACCOUNT).whereField("email", isEqualTo: user?.email ?? "")
        
        ref.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting document(s): \(err)")
                completion(Account())
            } else {
                let document = querySnapshot!.documents.first
                if (document != nil) {
                    self.account = Account(id: document!.documentID, dictionary: document!.data())
                }
            }
        }
    }
    
    func getCurrentFriendRequests(completion: @escaping ([Account]) -> Void) {
        self.getCurrentAccount() { account in
            let group = DispatchGroup()
            var friendAccounts : [Account] = []
            // For each friend document ID, convert into Account
            account.friendRequests.forEach { friendDocID in
                group.enter() // Started async request (get from Firebase)
                let friendRef = self.store.collection(self.COLLECTION_ACCOUNT).document(friendDocID)
                friendRef.getDocument() { (document, error) in
                    if let document = document {
                        if (document.data() != nil) {
                            friendAccounts.append(Account(id: document.documentID, dictionary: document.data()!))
                        }
                    } else {
                        print("Document does not exist")
                    }
                    group.leave() // Finished async request
                }
            }
            
            // Wait for all request to finish
            group.notify(queue: .main) {
                completion(friendAccounts)
            }
        }
    }
    
    func getCurrentAccountFriends(completion: @escaping ([Account]) -> Void) {
        self.getCurrentAccount() { account in
            let group = DispatchGroup()
            var friendAccounts : [Account] = []
            // For each friend document ID, convert into Account
            account.friends.forEach { friendDocID in
                group.enter() // Started async request (get from Firebase)
                let friendRef = self.store.collection(self.COLLECTION_ACCOUNT).document(friendDocID)
                friendRef.getDocument() { (document, error) in
                    if let document = document {
                        if (document.data() != nil) {
                            friendAccounts.append(Account(id: document.documentID, dictionary: document.data()!))
                        }
                    } else {
                        print("Document does not exist")
                    }
                    group.leave() // Finished async request
                }
            }
            
            // Wait for all request to finish
            group.notify(queue: .main) {
                completion(friendAccounts)
            }
        }
    }
    
    func allAccounts(completion: @escaping (Account) -> Void){
        var accounts : [Account] = []
        store.collection(COLLECTION_ACCOUNT).document()
    }
    
    func sendFriendRequest(id : String){
    
    }
    
    func getFriendsPost(completion: @escaping ([Post]) -> Void) {
        self.getCurrentAccountFriends() { friendAccounts in
            let group = DispatchGroup()
            var friendPosts : [Post] = []
            
            friendAccounts.forEach { account in
                account.posts.forEach { post in
                    group.enter()
                    let postRef = self.store.collection(self.COLLECTION_POST).document(post)
                    postRef.getDocument() { (document, err) in
                        if let document = document {
                            if document.data() != nil {
                                friendPosts.append(Post(dictionary: document.data()!) ?? Post())
                            }
                        } else {
                            print("Document does not exist")
                        }
                        group.leave()
                    }
                }
            }
            
            group.notify(queue: .main) {
                completion(friendPosts)
            }
        }
    }
    
    func changePassword(newPassword : String, completion: @escaping (Bool) -> Void) {
        Auth.auth().currentUser?.updatePassword(to: newPassword) { error in
            if let error = error {
                print("Error while updating password", error)
                completion(false)
            } else {
                print("Successfully updated password")
                completion(true)
            }
        }
        
    }
    
    func removeUserAccount(email: String) {
        let ref = store.collection(COLLECTION_ACCOUNT).whereField("email", isEqualTo: email)
        ref.getDocuments { (querySnapshot, err) in
            if let err = err {
               print("Error getting document(s): \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.store.collection(self.COLLECTION_ACCOUNT).document(document.documentID).delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            print("Document successfully removed!")
                        }
                    }
                }
            }
        }
    }
    
    func deleteAccount() {
        let user = Auth.auth().currentUser
        let email = user?.email
        user?.delete { error in
            if let error = error {
                print(#function, "Error while deleting account", error)
            } else {
                print(#function, "Successfully deleted account")
                self.removeUserAccount(email: email ?? "")
            }
        }
    }
    
    func uploadImage(image: UIImage, descriptor: String){
        let storageRef = storage.reference().child("\(descriptor).jpg")
        
//        let newWidth = CGFloat(200)
//
//        let scale = newWidth / image.size.width
//        let newHeight = image.size.height * scale
//
//        let resizedImage = image.scaleImage(toSize: CGSize(width: newWidth, height: newHeight))
        
        let corOrientation = image.fixedOrientation()

        // Convert the image into JPEG and compress the quality to reduce its size
        let data = corOrientation!.jpegData(compressionQuality: 0.2)
        
        print(data!.description)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
    
        
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                        print("Error while uploading file: ", error)
                }

                if let metadata = metadata {
                        print("Metadata: ", metadata)
                }
            }
        }
    }
        

    func getImage(url: String, completion: @escaping (UIImage?) -> Void){
        let reference = Storage.storage().reference(withPath: "\(url).jpg")
        reference.getData(maxSize: (1 * 1024 * 1024)) { (data, error) in
            if let _error = error{
                print(_error)
            } else {
                if let _data = data{
                    completion(UIImage(data: _data))
                }
            }
        }
    }
    
    func insertPost(postData: Post){
        do{
            try self.store.collection("Posts").addDocument(from: postData)
        }catch let error as NSError{
            print(#function, "Error while inserting the Account", error)
        }
    }
    
    func getGeoHash(location: CLLocationCoordinate2D) -> String{
        return GFUtils.geoHash(forLocation: location)
    }
    
    func deleteRequest(userId: String, friendId: String){
        let ref = store.collection(COLLECTION_ACCOUNT).document(userId)
        ref.updateData([
            "friendRequests": FieldValue.arrayRemove([friendId])
        ])
    }
    
    func addFriend(userId: String, friendId: String){
        let ref = store.collection(COLLECTION_ACCOUNT).document(userId)
        ref.updateData([
            "friendRequests": FieldValue.arrayUnion([friendId])
        ])
    }
    
    func geoQuery(center : CLLocationCoordinate2D) {
        
        print("zGEO QUERY EXE \(center)")
        
        // Find posts within 50km of center
        let radiusInM: Double = 50 * 1000

        // Each item in 'bounds' represents a startAt/endAt pair. We have to issue
        // a separate query for each pair. There can be up to 9 pairs of bounds
        // depending on overlap, but in most cases there are 4.
        let queryBounds = GFUtils.queryBounds(forLocation: center, withRadius: radiusInM)
        let queries = queryBounds.map { bound -> Query in
            return store.collection("Posts")
                .order(by: "geoHash")
                .start(at: [bound.startValue])
                .end(at: [bound.endValue])
        }

        var matchingDocs = [Post]()
        let myGroup = DispatchGroup()
        // Collect all the query results together into a single list
        func getDocumentsCompletion(snapshot: QuerySnapshot?, error: Error?) -> () {
            guard let documents = snapshot?.documents else {
                print("Unable to fetch snapshot data. \(String(describing: error))")
                return
            }
            
            print("Passed Gaurd \(documents.count)")

            for document in documents {
                print("document \(document)")
               
                let lat = document.data()["latitude"] as? Double ?? 0
                let lng = document.data()["longitude"] as? Double ?? 0
                
                print("zLAT, LNG\(lat)\(lng)")
                
                let coordinates = CLLocation(latitude: lat, longitude: lng)
                let centerPoint = CLLocation(latitude: center.latitude, longitude: center.longitude)

                // We have to filter out a few false positives due to GeoHash accuracy, but
                // most will match
                let distance = GFUtils.distance(from: centerPoint, to: coordinates)
                
                var post = Post()
                if distance <= radiusInM {
                    
                    do{
                        post = try document.data(as: Post.self)!
                        
                        print("Post Name \(post.name)")
                        
                        matchingDocs.append(post)
                    }
                    catch let error as NSError{
                        print(#function, "error while gettting document change", error)
                    }
                   
                }
            }
            myGroup.leave()
        }

        // After all callbacks have executed, matchingDocs contains the result. Note that this
        // sample does not demonstrate how to wait on all callbacks to complete.
        for query in queries {
            myGroup.enter()
            query.getDocuments(completion: getDocumentsCompletion)
        }
         
         myGroup.notify(queue: .main) {
             self.nearbyPosts = matchingDocs
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

