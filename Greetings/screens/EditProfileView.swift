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
    
    @State private var isShowImagePicker = false
    @State private var image: UIImage? = nil
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else {
                        Image(systemName: "person.crop.circle")
                    } 
                    
                    Button("pick") {
                        isShowImagePicker.toggle()
                    }
                    
                }
                
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
                        FireUser.updateMyUser(userName: userName, displayName: displayName, introduction: introduction, icon: nil)
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
        
        .sheet(isPresented: $isShowImagePicker) {
            ImagePickerView(image: $image)
        }
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
