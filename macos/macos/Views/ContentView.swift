import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView().environmentObject(SingleObserver(value: "録画")) // 初期選択タブを "録画" としています
    }
}

