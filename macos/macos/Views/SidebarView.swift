//
//  Sidebarview.swift
//  macos
//
//  Created by 小林駿斗 on 2024/02/14.
//

import SwiftUI

struct SidebarView: View {
    @EnvironmentObject var selectedTab: TabObserver
    @EnvironmentObject var login: LoginObserver
    
    private let tabs = [
        ("camera.on.rectangle", "録画"),
        ("book.pages", "スクリプト"),
        ("gearshape", "設定"),
        ("pencil.and.scribble", "Chatty")
    ]
    
    var body: some View {
        VStack {
            Text(greetingMessage())
                .font(.title)
                .bold().padding([.top, .trailing, .bottom], 20)
            List {
                ForEach(tabs, id: \.1) { icon, name in
                    HStack {
                        Image(systemName: icon)
                            .foregroundColor(selectedTab.value == name ? .green : .gray)
                            .imageScale(.large)
                        Text(name)
                            .foregroundColor(selectedTab.value == name ? .primary : .secondary)
                    }
                    .padding(.vertical, 4)
                    .cornerRadius(8)
                    .onTapGesture {
                        selectedTab.value = name
                    }
                    .listRowBackground(selectedTab.value == name ? Color.green.opacity(0.2) : Color.clear)
                }
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 200, idealWidth: 250, maxWidth: 300)
            
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView().environmentObject(TabObserver(value: "録画")).environmentObject(LoginObserver(isLoggedIn: false, accountName: "小林駿斗"))
    }
}
