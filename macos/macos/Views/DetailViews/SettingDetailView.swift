//
//  SettingDetailView.swift
//  macos
//
//  Created by 小林駿斗 on 2024/02/20.
//

import SwiftUI

struct SettingDetailView: View {
    @EnvironmentObject var login: LoginObserver
    var body: some View {
        VStack
        {   HStack
            {
                Image("Account")
                    .resizable().scaledToFit().imageScale(.small).frame(width: 30, height: 30).clipShape(Circle())
                Text(login.accountName ?? "アカウント名").font(.title).bold()
            }
           
            Button(action: {
                self.login.isLoggedIn = false
            }) {
                Text("ログアウト")
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SettingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SettingDetailView().environmentObject(LoginObserver(isLoggedIn: false, accountName: "小林駿斗"))
    }
}
