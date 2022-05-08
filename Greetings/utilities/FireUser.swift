//
//  FireUser.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import Firebase

class FireUser {
    
    static func readUser(userId: String, completion: ((User?) -> Void)?) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .getDocument { (document, error) in
                if let document = document, document.exists {
                    let user = User(documentSnapshot: document)
                    print("HELLO! Success! Read User identified as \(userId). Size: 1")
                    completion?(user)
                } else {
                    print("HELLO! Fail! User identified as \(userId) does not exist.")
                    completion?(nil)
                }
            }
    }
    
    static func readFollowings(userId: String, completion: (([User]) -> Void)?) {
        
        // followingsフィールドを確認するためにUserドキュメントを取得
        readUser(userId: userId) { user in
            if let user = user {
                let followingsIds = user.followings
                
                // 誰もフォローしていない場合は空配列を返す
                if followingsIds.isEmpty {
                    let users: [User] = []
                    completion?(users)
                    return
                }
                
                // フォローしているユーザーのUserドキュメントを取得
                let db = Firestore.firestore()
                db.collection("users")
                    .whereField(FieldPath.documentID(), in: followingsIds)
                    .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("HELLO! Fail! Error reading Users followed by \(userId): \(err)")
                        } else {
                            print("HELLO! Success! Read Users followed by \(userId). Size: \(querySnapshot!.documents.count)")
                            var users: [User] = []
                            for document in querySnapshot!.documents {
                                let user = User(documentSnapshot: document)
                                users.append(user)
                            }
                            completion?(users)
                        }
                    }
            }
        }
    }
    
    static func readFollowers(userId: String, completion: (([User]) -> Void)?) {
        let db = Firestore.firestore()
        db.collection("users")
            .whereField("followings", arrayContains: userId)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error reading Users following \(userId). Error: \(err)")
                } else {
                    print("HELLO! Success! Read Users following \(userId). Size: \(querySnapshot!.documents.count)")
                    var users: [User] = []
                    for document in querySnapshot!.documents {
                        let user = User(documentSnapshot: document)
                        users.append(user)
                    }
                    completion?(users)
                }
            }
    }
    
    static func createUser(userId: String, userName: String, displayName: String, introduction: String, icon: String?) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .setData([
            "userName": userName,
            "displayName": displayName,
            "introduction": introduction,
            "icon": icon as Any,
            "followings": [],
            "followers": []
        ]) { err in
            if let err = err {
                print("HELLO! Fail! Error writing User: \(err)")
            } else {
                print("HELLO! Success! User successfully written!")
            }
        }
    }
    
    static func followUser(userId: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(FireAuth.userId())
            .updateData([
                "followings": FieldValue.arrayUnion([userId])
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating User. Error: \(err)")
                } else {
                    print("HELLO! Success! User successfully updated.")
                }
            }
    }
    
    static func unfollowUser(userId: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(FireAuth.userId())
            .updateData([
                "followings": FieldValue.arrayRemove([userId])
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating User. Error: \(err)")
                } else {
                    print("HELLO! Success! User successfully updated.")
                }
            }
    }
    
    static func updateMyUser(userName: String, displayName: String, introduction: String, icon: String?) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(FireAuth.userId())
            .updateData([
                "userName": userName,
                "displayName": displayName,
                "introduction": introduction,
                "icon": icon as Any
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating User. Error: \(err)")
                } else {
                    print("HELLO! Success! User successfully updated.")
                }
            }
    }
    
    static func deleteUser() {
        
    }
    
}
