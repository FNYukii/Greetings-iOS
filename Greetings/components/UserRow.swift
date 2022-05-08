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
        VStack {
            HStack(alignment: .top) {
                Image(systemName: "person.crop.circle")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
                
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

//struct UserRow_Previews: PreviewProvider {
//    static var previews: some View {
//        UserRow()
//    }
//}
