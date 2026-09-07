//
//  ContentView.swift
//  TrainingApp Watch App Watch App
//

import SwiftUI

// Root screen: pick a drill and go, phone not required. Uses whatever config
// was last synced from the phone for that drill type, falling back to the
// setup screen's own defaults if nothing's synced yet.
struct ContentView: View {
    @ObservedObject private var session = WatchSessionCoordinator.shared
    @State private var isDrillActive = false
    @State private var selectedDrillType = "colorCall"

    private let drills: [(type: String, title: String)] = [
        ("colorCall", "Color Call"),
        ("numberCall", "Number Call"),
        ("directionCall", "Direction Call"),
    ]

    var body: some View {
        NavigationStack {
            List(drills, id: \.type) { drill in
                Button(drill.title) {
                    selectedDrillType = drill.type
                    isDrillActive = true
                }
            }
            .navigationTitle("Phesian")
        }
        .sheet(isPresented: $isDrillActive) {
            WatchDrillView(
                engineConfig: currentPayload(for: selectedDrillType).engineConfiguration,
                drillType: selectedDrillType
            )
        }
    }

    private func currentPayload(for drillType: String) -> DrillConfigPayload {
        session.configs[drillType] ?? DrillConfigPayload.defaultPayload(drillType: drillType)
    }
}

#Preview {
    ContentView()
}
