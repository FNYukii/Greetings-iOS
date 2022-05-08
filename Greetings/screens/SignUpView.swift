//
//  SignUpView.swift
//  Greetings
//
//  Created by Yu on 2022/05/07.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var userName = ""
    @State private var displayName = ""
    @State private var introduction = ""
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    TextField("email", text: $email)
                    TextField("password", text: $password)
                }
                Section {
                    TextField("user-name", text: $userName)
                    TextField("display-name", text: $displayName)
                    MyTextEditor(hint: "introduction", text: $introduction)
                }
            }
            
            .navigationTitle("sign-up")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action :{
                        FireAuth.signUp(email: email, password: password) { userId in
                            if let userId = userId {
                                FireUser.createUser(userId: userId, userName: userName, displayName: displayName, introduction: introduction, icon: nil)
                            }
                        }
                        dismiss()
                    }) {
                        Text("done")
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
