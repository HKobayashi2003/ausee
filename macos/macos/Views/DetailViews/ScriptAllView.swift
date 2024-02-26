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
    @ObservedObject var viewModel: ChaptersServer
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 30)
                Text("スクリプト作成")
                    .font(.title).bold()
                TextField("タイトルを入力", text: $inputTheme)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                ForEach($viewModel.chapters) { $chapter in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(chapter.title)
                                .font(.title2)
                            Spacer()
                            Button(action: {
                                if viewModel.chapters.count > 1 { // 正しい配列への参照
                                    viewModel.chapters.removeAll(where: { $0.id == chapter.id })
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

struct ScriptAllView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ChaptersServer()
        ScriptAllView(viewModel: viewModel).environmentObject(ChaptersServer())
    }
}
