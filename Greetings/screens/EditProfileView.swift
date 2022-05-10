//
//  EditProfileView.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    private let iconSide: CGFloat = 60

    @State private var displayName = ""
    @State private var userName = ""
    @State private var introduction = ""
    
    @State private var isShowImagePicker = false
    @State private var iconImage: UIImage? = nil
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Button(action: {
                        isShowImagePicker.toggle()
                    }) {
                        if let image = iconImage {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: iconSide, height: iconSide)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: iconSide, height: iconSide)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    VStack {
                        TextField("display-name", text: $displayName)
                        Divider()
                        
                        TextField("user-name", text: $userName)
                            .padding(.top, 4)
                        Divider()
                    }
                    
                    Spacer()
                }
                
                MyTextEditor(hint: "introduction", text: $introduction)
                    .frame(height: 150)
                Divider()
                
                Spacer()
            }
            .padding()
            
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
                        if let image = iconImage {
                            FireImage.uploadImage(image: image)
                        }
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
            ImagePickerView(image: $iconImage)
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
