//
//  CurrentUser.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import Foundation
import FirebaseAuth

class FireAuth {
    
    static func userId() -> String {
        let user = Auth.auth().currentUser
        if let user = user {
            return user.uid
        }
        return ""
    }
    
    static func userEmail() -> String {
        let email = Auth.auth().currentUser?.email
        if let email = email {
            return email
        }
        return ""
    }
    
    static func signUp(email: String, password: String) {
        
    }
    
    static func signIn(email: String, password: String) {
        
    }
    
    static func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("HELLO! Fail! Error signing out")
        }
    }
}
