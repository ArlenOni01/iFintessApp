//
//  ContentView.swift
//  TrainingApp
//
//  Created by Arlen Oni on 10/30/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showMenu = false
    @State private var selectedTab = 0

    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selectedTab) {
                    HomePage()
                        .tabItem { Label("Home", systemImage: "house.fill") }
                        .tag(0)
                    DrillsPage()
                        .tabItem { Label("Train", systemImage: "flag.checkered") }
                        .tag(1)
                    MobilityPage()
                        .tabItem { Label("Mobility", systemImage: "figure.flexibility") }
                        .tag(2)
                    HistoryPage()
                        .tabItem { Label("History", systemImage: "clock.fill") }
                        .tag(3)
                }
                SideMenuView(isShowing: $showMenu, selectedTab: $selectedTab)
            }
            .toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showMenu.toggle()
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                    })
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
