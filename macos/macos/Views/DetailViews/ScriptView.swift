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
            ScriptSidebarView(chapters: $chapters)
        } detail: {
            ScrollView {
                VStack {
                    Text("スクリプト作成")
                        .font(.title).bold()
                    TextField("テーマを入力", text: $inputTheme)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Text("章構造を入力")
                        .font(.title)
                    TextField("章を追加", text: $newChapter)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    HStack {
                        Button(action: {
                            // 章を追加する
                            chapters.append(Chapter(title: newChapter, value: ""))
                            newChapter = ""
                        }) {
                            Image(systemName: "plus")
                        }
                        Button(action: {
                            // 章を削除する
                            if chapters.count > 1 {
                                chapters.removeLast()
                            }
                        }) {
                            Image(systemName: "minus")
                        }
                    }
                    .padding()
                    
                    ForEach($chapters) { $chapter in
                        VStack(alignment: .leading) {
                            Text(chapter.title)
                                .font(.title2)
                            TextField("", text: $chapter.value)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
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
