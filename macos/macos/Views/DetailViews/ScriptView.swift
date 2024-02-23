import SwiftUI

struct Chapter: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var value: String
}

struct ScriptView: View {
    @State var inputTheme = ""
    @State var newChapter = ""
    @State var allOrNot = true
    @State var selectedChapter: Chapter? = nil
    
    @State var chapters: [Chapter] = [
        Chapter(title: "導入", value: ""),
        Chapter(title: "現状分析", value: ""),
        Chapter(title: "原因分析", value: ""),
        Chapter(title: "解決策", value: ""),
        Chapter(title: "まとめ", value: "")
    ]
    
    var body: some View {
        NavigationSplitView {
            VStack {
                HStack {
                    TextField("章を追加", text: $newChapter)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        if !newChapter.isEmpty {
                            chapters.append(Chapter(title: newChapter, value: ""))
                            newChapter = ""
                        }
                    }) {
                        Image(systemName: "plus")
                    }
                }
                .padding()
                
                Button(action: {
                    allOrNot = true
                }) {
                    Text("全てみる")
                }
                
                List {
                    ForEach(chapters) { chapter in
                        NavigationLink(destination: TextEditView(chapter: $chapters[chapters.firstIndex(of: chapter)!])) {
                            Text(chapter.title).font(.title2)
                        }.simultaneousGesture(TapGesture().onEnded {
                            allOrNot = false
                            selectedChapter = chapter
                        })
                    }
                    .onMove(perform: moveChapter)
                }
            }
        } detail: {
            if allOrNot {
                ScriptAllView()
            } else if let selectedChapter = selectedChapter {
                TextEditView(chapter: .constant(selectedChapter))
            } else{
                Text("何も選択されてません")
            }
        }
    }
    
    private func moveChapter(from source: IndexSet, to destination: Int) {
        chapters.move(fromOffsets: source, toOffset: destination)
    }
}

struct TextEditView: View {
    @Binding var chapter: Chapter // 修正: Bindingを追加
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text(chapter.title)
                    .font(.title2)
                TextEditor(text: $chapter.value)
                    .frame(height: 200)
                    .border(Color.gray, width: 1)
            }
        }
        .padding()
    }
}

struct ScriptView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptView()
    }
}
