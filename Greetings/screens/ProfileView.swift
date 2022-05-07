//
//  ProfileView.swift
//  Greetings
//
//  Created by Yu on 2022/05/07.
//

import SwiftUI

struct ProfileView: View {
    
    let userId: String
    @State private var user: User? = nil
    

    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack {
                    Image(systemName: "person.crop.circle")
                        .font(.largeTitle)
                    VStack(alignment: .leading) {
                        Text(user != nil ? user!.displayName : "nothing")
                            .fontWeight(.bold)
                        Text(user != nil ? user!.userName : "nothing")
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding(.leading)
                
                Text(user != nil ? user!.introduction : "nothing")
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                
                HStack {
                    Text(user != nil ? "\(user!.followings.count)" : "nothing")
                    Text("followings")
                        .foregroundColor(.secondary)
                        .padding(.trailing)
                    Text(user != nil ? "\(user!.followers.count)" : "nothing")
                    Text("followers")
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                Divider()
            }
        }
        
        
        .onAppear {
            FireUser.read(id: userId) { user in
                if let user = user {
                    self.user = user
                }
            }
        }
        
        .navigationTitle(user != nil ? user!.displayName : "profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: {
                        
                    }) {
                        Label("edit", systemImage: "square.and.pencil")
                    }
                    Button(action: {
                        FireAuth.signOut()
                    }) {
                        Label("sign-out", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.title3)
                }
            }
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(userId: "jfaldjflakgjjg")
//    }
//}
