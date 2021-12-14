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


class FireDBHelper: ObservableObject{
    @Published var accountList = [Account]()
    @Published var isAuth : Bool = false
    @Published var signUpSuccess : Bool = false
    @Published var signedIn : Bool = false
    @Published var nearbyPosts = [PostData]()
    
    private let COLLECTION_NAME : String = "Accounts"
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
        do{
            try self.store.collection(COLLECTION_NAME).addDocument(from: newAccount)
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
    
    func createAccount(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password ){[weak self] authResult, error in

            if let error = error {
                print("Error when signing up: \(error)")
                return
            }
            else{
                print("NO Error when signing up!!!")
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
    
    func uploadImage(image: UIImage, descriptor: String){
        
        print("Starting upload")
        let storageRef = storage.reference().child("images/\(descriptor).jpg")
        
        let newWidth = CGFloat(200)
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        let resizedImage = image.scaleImage(toSize: CGSize(width: newWidth, height: newHeight))

        // Convert the image into JPEG and compress the quality to reduce its size
        let data = resizedImage!.jpegData(compressionQuality: 0.2)
        
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
    
    func getImage(url: String) -> UIImage?{
        
        var result: UIImage? = nil
        var error :String? = nil
        
        let reference = Storage.storage().reference(withPath: "\(url).jpg")
        reference.getData(maxSize: (1 * 1024 * 1024)) { (data, error) in
            if let _error = error{
                print(_error)
            } else {
               
                if let _data = data{
                    let myImage:UIImage! = UIImage(data: _data)
                    result =  myImage
                }
            }
        }
        
        return result
    }
    
    func insertPost(postData: PostData){
        do{
            try self.store.collection("Posts").addDocument(from: postData)
        }catch let error as NSError{
            print(#function, "Error while inserting the Account", error)
        }
    }
    
    func getGeoHash(location: CLLocationCoordinate2D) -> String{
        return GFUtils.geoHash(forLocation: location)
    }
    
    
    
    func geoQuery(center : CLLocationCoordinate2D) {
        
        print("GEO QUERY EXE")
        
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

        var matchingDocs = [PostData]()
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
                let coordinates = CLLocation(latitude: lat, longitude: lng)
                let centerPoint = CLLocation(latitude: center.latitude, longitude: center.longitude)

                // We have to filter out a few false positives due to GeoHash accuracy, but
                // most will match
                let distance = GFUtils.distance(from: centerPoint, to: coordinates)
                
                var post = PostData()
                if distance <= radiusInM {
                    
                    do{
                        post = try document.data(as: PostData.self)!
                        
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

