//
//  ContentView.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FirstView()
                .tabItem {
                    Label("home", systemImage: "house")
                }
            SecondView()
                .tabItem {
                    Label("search", systemImage: "magnifyingglass")
                }
            ThirdView()
                .tabItem {
                    Label("notifications", systemImage: "bell")
                }
        }
    }
}
