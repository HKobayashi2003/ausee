//
//  ScriptView.swift
//  macos
//
//  Created by 小林駿斗 on 2024/02/15.
//

import SwiftUI

struct ScriptView: View {
    @State var input = ""
    var body: some View {
        TextField("名前を入力してください", text:$input).padding()
    }
}

#Preview {
    ScriptView()
}
