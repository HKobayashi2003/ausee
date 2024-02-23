//
//  ScriptSidebar.swift
//  macos
//
//  Created by 小林駿斗 on 2024/02/18.
//

import SwiftUI

struct Chapter: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var value: String
}

struct ScriptSidebarView: View {
    @State private var inputTheme = ""
    @State private var newChapter = ""
    @Binding var chapters: [Chapter]
    
    var body: some View {
        NavigationView {
            List {
                ForEach($chapters) { $chapter in
                    VStack(alignment: .leading) {
                        Text(chapter.title).font(.title2)
                    }
                }
                .onDelete(perform: deleteChapter)
                .onMove(perform: moveChapter)
            }
            .navigationTitle("スクリプト作成")
        }
    }

    private func addChapter() {
        let new = Chapter(id: UUID(), title: "", value: "")
        chapters.append(new)
    }
    
    private func moveChapter(from source: IndexSet, to destination: Int) {
        chapters.move(fromOffsets: source, toOffset: destination)
    }

    private func deleteChapter(at offsets: IndexSet) {
        chapters.remove(atOffsets: offsets)
    }
}

struct ScriptSidebarView_Previews: PreviewProvider {
    @State static var previewsChapters: [Chapter] = [
        Chapter(title: "導入", value: ""),
        Chapter(title: "現状分析", value: ""),
        Chapter(title: "原因分析", value: ""),
        Chapter(title: "解決策", value: ""),
        Chapter(title: "まとめ", value: "")
    ]

    static var previews: some View {
        ScriptSidebarView(chapters: .constant(previewsChapters))
    }
}

