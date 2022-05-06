//
//  PostRow.swift
//  Greetings
//
//  Created by Yu on 2022/05/06.
//

import SwiftUI

struct PostRow: View {
    
    let displayName: String
    let userName: String
    let content: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "person.crop.circle")
                .font(.largeTitle)
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(displayName)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Text("@\(userName)")
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    Text("12時間前")
                        .foregroundColor(.secondary)
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.secondary)
                    }
                }
                Text(content)
            }
        }
        .padding(.horizontal)
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(displayName: "りんご好き", userName: "appler234222", content: "有馬温泉に旅行行ってきたよ。温泉めっちゃ気持ちよかった。")
    }
}
