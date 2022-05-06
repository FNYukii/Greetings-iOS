//
//  FirstView.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import SwiftUI

struct FirstView: View {
    
    @State private var isShowSheet = false
    
    var body: some View {
        NavigationView {
            List {
                PostRow(displayName: "太郎", userName: "Taro123", content: "今日は一日中休めるぞ")
                    .listRowSeparator(.hidden)
                PostRow(displayName: "ひかり", userName: "Hikarin14", content: "明日はお出かけする予定")
                    .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
            
            .sheet(isPresented: $isShowSheet) {
                CreateView()
            }
            
            .navigationTitle("home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // TODO: Open profile
                    }) {
                        Image(systemName: "person.crop.circle")
                            .font(.title2)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("new") {
                        isShowSheet.toggle()
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
