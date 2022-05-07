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
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $introduction)
                            .frame(minHeight: 80)
                        Text("introduction")
                            .foregroundColor(Color(UIColor.placeholderText))
                            .opacity(introduction.isEmpty ? 1 : 0)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                    }
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
                                FireUser.create(id: userId, userName: userName, displayName: displayName, introduction: introduction, icon: nil)
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
