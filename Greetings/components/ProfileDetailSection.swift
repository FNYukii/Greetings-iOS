//
//  ProfileSection.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import SwiftUI

struct ProfileDetailSection: View {
    
    private let showUserId: String
    @ObservedObject private var userViewModel: UserViewModel
    @ObservedObject private var followersCountViewModel: FollowersCountViewModel
    
    init(showUserId: String) {
        self.showUserId = showUserId
        self.userViewModel = UserViewModel(userId: showUserId)
        self.followersCountViewModel = FollowersCountViewModel(userId: showUserId)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.crop.circle")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
                VStack(alignment: .leading) {
                    Text(userViewModel.isLoaded ? userViewModel.user!.displayName : "---")
                        .fontWeight(.bold)
                    Text(userViewModel.isLoaded ? userViewModel.user!.userName : "---")
                        .foregroundColor(.secondary)
                }
                Spacer()
                if showUserId != FireAuth.userId() {
                    FollowButton(showUserId: showUserId)
                }
            }
            
            Text(userViewModel.isLoaded ? userViewModel.user!.introduction : "---")
                .padding(.vertical, 4)
            
            HStack {
                NavigationLink(destination: FollowingsView(showUserId: showUserId)) {
                    Text(userViewModel.isLoaded ? "\(userViewModel.user!.followings.count)" : "-")
                        .foregroundColor(.primary)
                    Text("followings")
                        .foregroundColor(.secondary)
                }
                .padding(.trailing)
                
                NavigationLink(destination: FollowersView(showUserId: showUserId)) {
                    if !followersCountViewModel.isLoaded {
                        Text("-")
                            .foregroundColor(.primary)
                    } else {
                        Text("\(followersCountViewModel.followersCount)")
                            .foregroundColor(.primary)
                    }
                    Text("followers")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal)
    }
}
