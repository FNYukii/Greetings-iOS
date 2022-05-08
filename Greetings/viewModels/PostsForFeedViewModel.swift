//
//  PostViewModel.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import Firebase
import SwiftUI

class PostsForFeedViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var isLoaded = true
    
    init(userId: String) {
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .addSnapshotListener { documentSnapshot, error in
                
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                
                print("Current data: \(data)")
                let user = User(documentSnapshot: document)
                
                var followingIds = user.followings
                if followingIds.isEmpty {
                    followingIds.append("ididid")
                }
                
                let db = Firestore.firestore()
                db.collection("posts")
                    .whereField("userId", in: followingIds)
                    .order(by: "createdAt", descending: true)
                    .addSnapshotListener {(snapshot, error) in
                        guard let snapshot = snapshot else {
                            print("HELLO! Fail! Error fetching snapshots: \(error!)")
                            return
                        }
                        print("HELLO! Success! Read Posts. Size: \(snapshot.documents.count)")
                        
                        var newPosts: [Post] = []
                        snapshot.documents.forEach { document in
                            let post = Post(queryDocumentSnapshot: document)
                            newPosts.append(post)
                        }
                        
                        withAnimation {
                            self.posts = newPosts
                            self.isLoaded = true
                        }
                    }
                
                
            }
    }
    
}
