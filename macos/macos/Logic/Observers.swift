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
