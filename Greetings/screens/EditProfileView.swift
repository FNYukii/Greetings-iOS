//
//  EditProfileView.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.dismiss) private var dismiss

    @State private var displayName = ""
    @State private var userName = ""
    @State private var introduction = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("display-name", text: $displayName)
                TextField("user-name", text: $userName)
                MyTextEditor(hint: "introduction", text: $introduction)
            }
            
            .navigationTitle("edit-profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action :{
                        // TODO: Update user
                        dismiss()
                    }) {
                        Text("done")
                            .fontWeight(.bold)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: load)
    }
    
    private func load() {
        FireUser.readUser(userId: FireAuth.userId()) { user in
            if let user = user {
                self.displayName = user.displayName
                self.userName = user.userName
                self.introduction = user.introduction
            }
        }
    }
}
