//
//  PostViewModel.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import Firebase
import SwiftUI

class PostViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var isLoaded = true
    
    init() {
        let db = Firestore.firestore()
        db.collection("posts")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener {(snapshot, error) in
                guard let snapshot = snapshot else {
                    print("HELLO! Fail! Error fetching snapshots: \(error!)")
                    return
                }
                print("HELLO! Success! Read Posts. Size: \(snapshot.documents.count)")
                
                var newPosts: [Post] = []
                snapshot.documents.forEach { document in
                    let post = Post(document: document)
                    newPosts.append(post)
                }
                
                withAnimation {
                    self.posts = newPosts
                    self.isLoaded = true
                }
            }
    }
    
}
