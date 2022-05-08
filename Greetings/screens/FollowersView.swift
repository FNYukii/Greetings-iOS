//
//  FollowersView.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import SwiftUI

struct FollowersView: View {
    
    private let showUserId: String
    
    init(showUserId: String) {
        self.showUserId = showUserId
    }
    
    var body: some View {
        List {
            
        }
        
        .navigationTitle("followers")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct FollowersView_Previews: PreviewProvider {
//    static var previews: some View {
//        FollowersView()
//    }
//}
