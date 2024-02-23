//
//  ScriptAllView.swift
//  macos
//
//  Created by 小林駿斗 on 2024/02/23.
//

import SwiftUI

struct ScriptAllView: View {
    @State var inputTheme = ""
    @State var newChapter = ""
    
    @State var chapters: [Chapter] = [
        Chapter(title: "導入", value: ""),
        Chapter(title: "現状分析", value: ""),
        Chapter(title: "原因分析", value: ""),
        Chapter(title: "解決策", value: ""),
        Chapter(title: "まとめ", value: "")
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 30)
                Text("スクリプト作成")
                    .font(.title).bold()
                TextField("タイトルを入力", text: $inputTheme)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                ForEach($chapters) { $chapter in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(chapter.title)
                                .font(.title2)
                            Spacer()
                            Button(action: {
                                if chapters.count > 1 {
                                    chapters.removeAll(where: { $0.id == chapter.id })
                                }
                            }) {
                                Image(systemName: "trash")
                            }
                        }
                        TextEditor(text: $chapter.value)
                            .frame(height: 200)
                            .border(Color.gray, width: 1)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ScriptAllView()
}
