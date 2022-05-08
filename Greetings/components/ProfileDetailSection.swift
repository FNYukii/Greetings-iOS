//
//  ProfileSection.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import SwiftUI

struct ProfileDetailSection: View {
    
    private let showUserId: String
    @State private var showUser: User? = nil
    @State private var isShowUserLoaded = false
    @ObservedObject private var followersCountViewModel: FollowersCountViewModel
    
    init(showUserId: String) {
        self.showUserId = showUserId
        self.followersCountViewModel = FollowersCountViewModel(userId: showUserId)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.crop.circle")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
                VStack(alignment: .leading) {
                    Text(isShowUserLoaded ? showUser!.displayName : "---")
                        .fontWeight(.bold)
                    Text(isShowUserLoaded ? showUser!.userName : "---")
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(.leading)
            
            Text(isShowUserLoaded ? showUser!.introduction : "---")
                .padding(.horizontal)
                .padding(.vertical, 4)
            
            HStack {
                NavigationLink(destination: FollowingsView(showUserId: showUserId)) {
                    Text(isShowUserLoaded ? "\(showUser!.followings.count)" : "-")
                        .foregroundColor(.primary)
                    Text("followings")
                        .foregroundColor(.secondary)
                }
                .padding(.trailing)
                
                NavigationLink(destination: FollowersView(showUserId: showUserId)) {
                    if !followersCountViewModel.isLoaded {
                        Text("-")
                            .foregroundColor(.secondary)
                    } else {
                        Text("\(followersCountViewModel.followersCount)")
                            .foregroundColor(.secondary)
                    }
                    Text("followers")
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
            
            Divider()
        }
        .onAppear(perform: load)
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
