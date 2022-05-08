//
//  FollowingsView.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import SwiftUI

struct FollowingsView: View {
    
    private let showUserId: String
    
    @State private var followings: [User] = []
    @State private var isFollowingsLoaded = false
    
    init(showUserId: String) {
        self.showUserId = showUserId
    }
    
    var body: some View {
        
        ScrollView {
            VStack {
                ForEach(followings) { user in
                    UserRow(showUser: user)
                }
            }
        }
        
        .onAppear {
            if !isFollowingsLoaded {
                FireUser.readFollowings(userId: showUserId) { users in
                    withAnimation {
                        self.followings = users
                        self.isFollowingsLoaded = true
                    }
                }
            }
        }
        
        .navigationTitle("followings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct FollowingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FollowingsView(showUserId: "hello")
//    }
//}
