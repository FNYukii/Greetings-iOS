//
//  UserRow.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import SwiftUI

struct UserRow: View {
    
    let showUser: User
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                NavigationLink(destination: ProfileView(showUserId: showUser.id)) {
                    Image(systemName: "person.crop.circle")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(showUser.displayName)")
                        .fontWeight(.bold)
                    
                    Text("\(showUser.userName)")
                        .foregroundColor(.secondary)
                    
                    Text("\(showUser.introduction)")
                }
            }
            Divider()
        }
        .padding()
    }
}
