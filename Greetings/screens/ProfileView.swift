//
//  ProfileView.swift
//  Greetings
//
//  Created by Yu on 2022/05/07.
//

import SwiftUI

struct ProfileView: View {
    
    private let showUserId: String
    @State private var navTitle = "---"
    @State private var selection = 0
    
    init(showUserId: String) {
        self.showUserId = showUserId
    }

    var body: some View {
        
        ScrollView {
            VStack {
                ProfileDetailSection(showUserId: showUserId)
                
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Button(action: {
                            selection = 0
                        }) {
                            Text("posts")
                                .fontWeight(.bold)
                                .foregroundColor(selection == 0 ? .primary : .secondary)
                        }
                        Spacer()
                        Button(action: {
                            selection = 1
                        }) {
                            Text("likes")
                                .fontWeight(.bold)
                                .foregroundColor(selection == 1 ? .primary : .secondary)
                        }
                        Spacer()
                    }
                    .padding(.bottom, 4)
                    Divider()
                }
                .padding(.top, 2)
                
                if selection == 0 {
                    ProfilePostsSection(showingUserId: showUserId)
                }
                if selection == 1 {
                    Text("likes here")
                }
                
            }
        }
        .onAppear(perform: load)
                
        .navigationTitle(navTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if showUserId == FireAuth.userId() {
                    ProfileMenu()
                } else {
                    FollowButton(showUserId: showUserId)
                }
            }
        }
    }
    
    private func load() {
        FireUser.readUser(userId: showUserId) { user in
            if let user = user {
                self.navTitle = user.displayName
            }
        }
    }
}
