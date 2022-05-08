//
//  ProfileMenu.swift
//  Greetings
//
//  Created by Yu on 2022/05/08.
//

import SwiftUI

struct ProfileMenu: View {
    var body: some View {
        Menu {
            Button(action: {
                // TODO: Edit
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
