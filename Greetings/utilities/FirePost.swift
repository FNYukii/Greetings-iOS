//
//  FirePost.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import Firebase

class FirePost {
    
    static func create(text: String) {
        let userId = CurrentUser.id()
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
    
    static func update() {
        // TODO: Update post
    }
    
    static func delete() {
        // TODO: Delete post
    }
}
