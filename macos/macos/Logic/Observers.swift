//
//  SingleObserver.swift
//  macos
//
//  Created by 小林駿斗 on 2024/02/16.
//

import Foundation

class SingleObserver<T> : ObservableObject {
    @Published var value: T
    init(value: T) {
        self.value = value
    }
}

//タブ管理
class TabObserver: SingleObserver<String> { }
//ログイン管理
class LoginObserver: ObservableObject {
    // ログイン状態
    @Published var isLoggedIn: Bool
    // アカウント名
    @Published var accountName: String?
   
    init(isLoggedIn: Bool, accountName: String? = nil) {
        self.isLoggedIn = isLoggedIn
        self.accountName = accountName
    }
}

class ChaptersServer: ObservableObject {
    @Published var chapters: [Chapter] = [
        Chapter(title: "導入", value: ""),
        Chapter(title: "現状分析", value: ""),
        Chapter(title: "原因分析", value: ""),
        Chapter(title: "解決策", value: ""),
        Chapter(title: "まとめ", value: "")
    ]
}

class PromptServer : ObservableObject{
    
    @Published var originalText: String
    @Published var promptText: String
    
    init (originalText: String, promptText: String){
        self.originalText = originalText
        self.promptText = promptText
    }
}
