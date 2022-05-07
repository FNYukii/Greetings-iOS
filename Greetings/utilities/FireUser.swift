//
//  FireUser.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import Firebase

class FireUser {
    
    // idからUserを取得して返す。Userが存在しなければnilを返す。
    static func read(id: String, completion: ((User?) -> Void)?) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .getDocument { (document, error) in
                if let document = document, document.exists {
                    let user = User(document: document)
                    print("HELLO! Success! userId: \(id), displayName: \(user.displayName)")
                    completion?(user)
                } else {
                    print("HELLO! Fail! Document User does not exist.")
                    completion?(nil)
                }
            }
    }
    
    static func readFollowings() {
        
    }
    
    static func readFollowers(id: String, completion: (([User]) -> Void)?) {
        let db = Firestore.firestore()
        db.collection("users")
            .whereField("folloings", arrayContains: id)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error getting documents: \(err)")
                } else {
                    var users: [User] = []
                    for document in querySnapshot!.documents {
                        let user = User(document: document)
                        users.append(user)
                    }
                    completion?(users)
                }
            }
    }
    
    static func create(id: String, userName: String, displayName: String, introduction: String, icon: String?) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData([
            "userName": userName,
            "displayName": displayName,
            "introduction": introduction,
            "icon": icon as Any,
            "followings": [],
            "followers": []
        ]) { err in
            if let err = err {
                print("HELLO! Fail! Error writing document: \(err)")
            } else {
                print("HELLO! Success! Document successfully written!")
            }
        }
    }
    
    static func follow(userId: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(FireAuth.userId())
            .updateData([
                "followings": FieldValue.arrayUnion([userId])
            ])
    }
    
    static func delete() {
        
    }
    
}
