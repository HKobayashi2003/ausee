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
    @StateObject var viewModel = ChaptersServer()
    
    var body: some View {
        NavigationSplitView {
            VStack {
                HStack {
                    TextField("章を追加", text: $newChapter)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        if !newChapter.isEmpty {
                            viewModel.chapters.append(Chapter(title: newChapter, value: ""))
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
                    ForEach($viewModel.chapters) { $chapter in
                        NavigationLink(destination: TextEditView(chapter: $chapter)) {
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
                ScriptAllView(viewModel: viewModel)
            } else if let selectedChapter = selectedChapter {
                TextEditView(chapter: Binding.constant(selectedChapter))
            } else {
                Text("何も選択されてません")
            }
        }
    }
    
    private func moveChapter(from source: IndexSet, to destination: Int) {
        viewModel.chapters.move(fromOffsets: source, toOffset: destination)
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
        ScriptView().environmentObject(ChaptersServer())
    }
}
