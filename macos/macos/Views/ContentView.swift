import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView().environmentObject(TabObserver(value: "録画")).environmentObject(LoginObserver(isLoggedIn: false, accountName: "小林駿斗")).environmentObject(ChaptersServer()).environmentObject(PromptServer(originalText: "", promptText: ""))
    }
}

