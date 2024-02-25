//
//  ScriptGenerationView.swift
//  macos
//
//  Created by 小林駿斗 on 2024/02/24.
//

import SwiftUI

struct ScriptGenerationView: View {
    @EnvironmentObject var promptServer: PromptServer
    
    var body: some View {
        Text(promptServer.originalText + promptServer.promptText)
            .padding()
            .frame(width: .infinity, height: .infinity)
    }
}

struct ScriptGenerationView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptGenerationView().environmentObject(PromptServer(originalText: "あいう", promptText: "これで文章作ってね"))
    }
}
