//
//  FirePost.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import Firebase

class FirePost {
    
    static func readPosts(userId: String, completion: (([Post]) -> Void)?) {
        let db = Firestore.firestore()
        db.collection("posts")
            .whereField("userId", isEqualTo: userId)
            .order(by: "createdAt", descending: true)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error getting documents: \(err)")
                } else {
                    var posts: [Post] = []
                    for document in querySnapshot!.documents {
                        let post = Post(document: document)
                        posts.append(post)
                    }
                    completion?(posts)
                }
        }
    }
    
    static func create(text: String) {
        let userId = FireAuth.userId()
        let db = Firestore.firestore()
        db.collection("posts")
            .addDocument(data: [
                "createdAt": Date(),
                "userId": userId,
                "text": text,
                "images": [],
                "likedUsers": []
            ]) { error in
                if let error = error {
                    print("HELLO! Fail! Error adding new Post: \(error)")
                } else {
                    print("HELLO! Success! Added Post")
                }
            }
    }
    
    static func like(id: String) {
        let db = Firestore.firestore()
        db.collection("posts")
            .document(id)
            .updateData([
                "likedUsers": FieldValue.arrayUnion([FireAuth.userId()])
            ])
    }
    
    static func unlike(id: String) {
        let db = Firestore.firestore()
        db.collection("posts")
            .document(id)
            .updateData([
                "likedUsers": FieldValue.arrayRemove([FireAuth.userId()])
            ])
    }
    
    static func delete(id: String) {
        // TODO: Delete post
        let db = Firestore.firestore()
        db.collection("posts")
            .document(id)
            .delete() { err in
            if let err = err {
                print("HELLO! Fail! Error removing document: \(err)")
            } else {
                print("HELLO! Success! Document Post successfully removed!")
            }
        }
    }
}
