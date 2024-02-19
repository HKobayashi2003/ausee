//
//  SetttingView.swift
//  macos
//
//  Created by 小林駿斗 on 2024/02/15.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var login: LoginObserver
    
    var body: some View {
        VStack{
            if login.isLoggedIn == false
                {
                    Button(action: {
                        self.login.isLoggedIn = true
                    }) {
                        Text("ログイン")
                    }
                }
            else
                {
                    SettingDetailView()
                }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SettingView().environmentObject(LoginObserver(isLoggedIn:false, accountName: "小林駿斗"))
}
