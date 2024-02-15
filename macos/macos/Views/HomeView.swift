//
//  Home.swift
//  macos
//
//  Created by 小林駿斗 on 2024/02/13.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var selectedTab: SelectedTab

    var body: some View {
        NavigationSplitView {
            SidebarView()
        } detail: {
            if selectedTab.selectedTab == "録画" {
                RecordView()
            } else if selectedTab.selectedTab == "スクリプト" {
                ScriptView()
            } else if selectedTab.selectedTab == "設定" {
                SettingView()
            } else {
                Text("選択されたタブに対応するビューがありません")
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(SelectedTab())
    }
}
