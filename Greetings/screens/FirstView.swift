//
//  FirstView.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Hello")
                Text("Hey")
            }
            
            .navigationTitle("home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("New") {
                        
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
