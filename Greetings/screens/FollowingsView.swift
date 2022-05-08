//
//  FollowingsView.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import SwiftUI

struct FollowingsView: View {
    
    private let showUserId: String
    
    init(showUserId: String) {
        self.showUserId = showUserId
    }
    
    var body: some View {
        List {
            
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
