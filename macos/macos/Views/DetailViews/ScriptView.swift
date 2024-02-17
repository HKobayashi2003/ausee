import SwiftUI

// 章を表す構造体
struct Chapter {
    var id: String
    var value: String
}

struct ScriptView: View {
    @State private var inputTheme = ""
    // 章のデータを持つ配列
    @State private var chapters: [Chapter] = [
        //あとでサンプルを作る。
        Chapter(id: "導入", value: ""),
        Chapter(id: "現状分析", value: ""),
        Chapter(id: "原因分析", value: ""),
        Chapter(id: "解決策", value: ""),
        Chapter(id: "まとめ", value: "")
    ]
    
    var body: some View {
        //スクロール可能に
        ScrollView{
            VStack {
                Text("スクリプト作成")
                    .font(.title).bold()
                TextField("テーマを入力", text: $inputTheme)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Text("章構造を入力")
                    .font(.title)
    
                ForEach($chapters, id: \.id) { $chapter in
                    VStack(alignment: .leading) {
                        Text(chapter.id) // 章のタイトルを表示
                            .font(.title2)
                        TextField("", text: $chapter.value)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.bottom, 2)
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct ScriptView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptView()
    }
}
