//
//  TrainingAppApp.swift
//  TrainingApp
//
//  Created by Arlen Oni on 10/30/23.
//

import SwiftUI
import Firebase

@main
struct TrainingAppApp: App {
    /*@StateObject var viewModel = AuthViewModel()
    @StateObject var manager = HealthManager()
    
    init() {
        FirebaseApp.configure()
    }*/
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                //.environmentObject(viewModel)
                //.environmentObject(manager)
        }
    }
}
