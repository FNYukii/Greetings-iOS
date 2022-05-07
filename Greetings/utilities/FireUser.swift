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
                    print("HELLO! Success!")
                    let user = User(document: document)
                    completion?(user)
                } else {
                    print("HELLO! Fail! Document does not exist.")
                    completion?(nil)
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
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    static func update() {
        
    }
    
    static func delete() {
        
    }
    
}
