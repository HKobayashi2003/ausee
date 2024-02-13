//
//  Home.swift
//  macos
//
//  Created by 小林駿斗 on 2024/02/13.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationSplitView{
            Sidebarview()
        }detail:{
            Detailview()
        }
       
    }
}

#Preview {
    Home()
}
