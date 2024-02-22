import SwiftUI

struct ScriptView: View {
    @State private var inputTheme = ""
    @State private var newChapter = ""
    // 章のデータを持つ配列
    @State private var chapters: [Chapter] = [
        Chapter(title: "導入", value: ""),
        Chapter(title: "現状分析", value: ""),
        Chapter(title: "原因分析", value: ""),
        Chapter(title: "解決策", value: ""),
        Chapter(title: "まとめ", value: "")
    ]
    
    var body: some View {
        NavigationSplitView {
            HStack {TextField("章を追加", text: $newChapter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    // 章を追加する
                    chapters.append(Chapter(title: newChapter, value: ""))
                    newChapter = ""
                }) {
                    Image(systemName: "plus")
                }
            }
            .padding()
            ScriptSidebarView(chapters: $chapters)
        } detail: {
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
                                    // 章を削除する
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
}

struct ScriptView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptView()
    }
}
