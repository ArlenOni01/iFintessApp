//
//  ContentView.swift
//  TrainingApp
//
//  Created by Arlen Oni on 10/30/23.
//

import SwiftUI

struct ContentView: View {
    //@EnvironmentObject var viewModel: AuthViewModel
    @State private var showMenu = false
    @State private var selectedTab = 0
    
    var body: some View {
        /*Group {
            if viewModel.userSession != nil {
                AppTabBarView()
            } else {
                LoginPage()
            }
        }*/
        NavigationStack {
            ZStack {
                TabView(selection: $selectedTab) {
                    // Main Content: HomePage view as the opening page
                    HomePage()
                        .tag(0)
                    NutritionPage()
                        .tag(1)
                    TimerPage()
                        .tag(2)
                    DrillsPage()
                        .tag(3)
                    BingoBoardView()
                        .tag(4)
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

 
