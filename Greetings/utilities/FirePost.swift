//
//  FirePost.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import Firebase

class FirePost {
    
    static func readPost(postId: String, completion: ((Post?) -> Void)?) {
        let db = Firestore.firestore()
        db.collection("posts")
            .document(postId)
            .getDocument { (document, error) in
                if let document = document, document.exists {
                    let post = Post(documentSnapshot: document)
                    print("HELLO! Success! Read Post identified as \(postId). Size: 1")
                    completion?(post)
                } else {
                    print("HELLO! Fail! Post identified as \(postId) does not exist.")
                    completion?(nil)
                }
            }
    }
    
    static func readPosts(userId: String, completion: (([Post]) -> Void)?) {
        let db = Firestore.firestore()
        db.collection("posts")
            .whereField("userId", isEqualTo: userId)
            .order(by: "createdAt", descending: true)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("HELLO! Fail! Error reading Posts posted by \(userId). Error: \(err)")
                } else {
                    print("HELLO! Success! Read Posts posted by \(userId). Size: \(querySnapshot!.documents.count)")
                    var posts: [Post] = []
                    for document in querySnapshot!.documents {
                        let post = Post(documentSnapshot: document)
                        posts.append(post)
                    }
                    completion?(posts)
                }
        }
    }
    
    static func createPost(text: String) {
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
                    print("HELLO! Fail! Error adding new Post. Error: \(error)")
                } else {
                    print("HELLO! Success! Added new Post.")
                }
            }
    }
    
    static func likePost(postId: String) {
        let db = Firestore.firestore()
        db.collection("posts")
            .document(postId)
            .updateData([
                "likedUsers": FieldValue.arrayUnion([FireAuth.userId()])
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating Post. Error: \(err)")
                } else {
                    print("HELLO! Success! Post successfully updated.")
                }
            }
    }
    
    static func unlikePost(postId: String) {
        let db = Firestore.firestore()
        db.collection("posts")
            .document(postId)
            .updateData([
                "likedUsers": FieldValue.arrayRemove([FireAuth.userId()])
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating Post. Error: \(err)")
                } else {
                    print("HELLO! Success! Post successfully updated.")
                }
            }
    }
    
    static func deletePost(postId: String) {
        // TODO: Delete post
        let db = Firestore.firestore()
        db.collection("posts")
            .document(postId)
            .delete() { err in
            if let err = err {
                print("HELLO! Fail! Error removing Post. Error: \(err)")
            } else {
                print("HELLO! Success! Post successfully removed!")
            }
        }
    }
}
