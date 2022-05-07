//
//  SignInStateViewModel.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import FirebaseAuth

class SignInStateViewModel: ObservableObject {
    
    @Published var isSignedIn: Bool = false
    @Published var isUserExist: Bool = false
    @Published var isLoaded = false
    
    private var handle: AuthStateDidChangeListenerHandle!
    
    init() {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.isSignedIn = true
                FireUser.read(id: user!.uid) { user in
                    if user != nil {
                        self.isUserExist = true
                    }
                    self.isLoaded = true
                }
            }
            
            if user == nil {
                self.isSignedIn = false
                self.isLoaded = true
            }
        }
    }
    
    deinit {
        Auth.auth().removeStateDidChangeListener(handle)
    }
}
