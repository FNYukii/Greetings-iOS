//
//  ProfileMenu.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import SwiftUI

struct ProfileMenu: View {
    
    private let showUserId: String
    @State private var showUser: User? = nil
    @State private var isShowUserLoaded = false
    
    @State private var isShowSheet = false
    
    init(showUserId: String) {
        self.showUserId = showUserId
    }
    
    var body: some View {
        Menu {
            
            // 他人のプロフィールを表示している場合
            if showUserId != FireAuth.userId() {
                Button(action: {
                    // TODO: Mute
                }) {
                    Label("mute \(isShowUserLoaded ? showUser!.userName: "---")", systemImage: "speaker.slash")
                }
                Button(action: {
                    // TODO: Block
                }) {
                    Label("block \(isShowUserLoaded ? showUser!.userName: "---")", systemImage: "nosign")
                }
            }
            
            // 自分のプロフィールを表示している場合
            if showUserId == FireAuth.userId() {
                Button(action: {
                    isShowSheet.toggle()
                }) {
                    Label("edit-profile", systemImage: "square.and.pencil")
                }
                Button(role: .destructive) {
                    FireAuth.signOut()
                } label: {
                    Label("sign-out", systemImage: "rectangle.portrait.and.arrow.right")

                }
            }
        } label: {
            Image(systemName: "ellipsis")
                .padding(.vertical)
                .foregroundColor(.secondary)
        }
        .onAppear(perform: load)
        
        .sheet(isPresented: $isShowSheet) {
            EditProfileView()
        }
    }
    
    private func load() {
        FireUser.readUser(userId: showUserId) { user in
            if let user = user {
                withAnimation {
                    self.showUser = user
                    self.isShowUserLoaded = true
                }
            }
        }
    }
}
