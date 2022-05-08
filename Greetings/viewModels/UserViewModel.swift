//
//  UserViewModel.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import Firebase
import SwiftUI

class UserViewModel: ObservableObject {
    
    @Published var user: User? = nil
    @Published var isLoaded = false
    
    init(userId: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("HELLO! Fail! Error reading User identified as \(userId). Error: \(error!)")
                    return
                }
                guard let _ = document.data() else {
                    print("HELLO! Fail! User identified as \(userId) was empty.")
                    return
                }
                print("HELLO! Success! Read User identified as \(userId). Size: 1")
                
                let user = User(documentSnapshot: document)
                withAnimation {
                    self.user = user
                    self.isLoaded = true
                }
            }
    }
    
}
