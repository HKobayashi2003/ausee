import SwiftUI

struct ContentView: View {
    var selectedTab = SelectedTab()
    var body: some View {
        HomeView().environmentObject(selectedTab)
    }
}
