//
//  TrainingAppApp.swift
//  TrainingApp
//
//  Created by Arlen Oni on 10/30/23.
//

import SwiftUI
import SwiftData

@main
struct TrainingAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: SessionRecord.self)
    }
}
