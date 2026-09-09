//
//  HomePage.swift
//  TrainingApp
//
//  Created by Arlen Oni on 11/2/23.
//

import SwiftUI
import SwiftData

struct HomePage: View {
    @Query(sort: \SessionRecord.date, order: .reverse) private var sessions: [SessionRecord]

    // MARK: - Computed stats

    private var totalSessions: Int { sessions.count }

    private var totalReps: Int { sessions.reduce(0) { $0 + $1.repsCompleted } }

    private var streak: Int {
        let cal = Calendar.current
        guard !sessions.isEmpty else { return 0 }
        var count = 0
        var checkDay = cal.startOfDay(for: Date())
        let sessionDays = Set(sessions.map { cal.startOfDay(for: $0.date) })
        while sessionDays.contains(checkDay) {
            count += 1
            guard let prev = cal.date(byAdding: .day, value: -1, to: checkDay) else { break }
            checkDay = prev
        }
        return count
    }

    private var recentSessions: [SessionRecord] { Array(sessions.prefix(3)) }

    private var lastDrillType: String? { sessions.first?.drillType }

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.0, green: 0.1, blue: 0.7), Color.teal.opacity(0.3)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 24) {

                    // MARK: Header
                    VStack(spacing: 8) {
                        Image("HomeLogo-noBackground")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .shadow(radius: 8)

                        Text("Phesian")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("Train smarter. React faster.")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.75))
                    }
                    .padding(.top, 32)

                    // MARK: Stats Row
                    HStack(spacing: 12) {
                        StatChip(value: "\(totalSessions)", label: "Sessions")
                        StatChip(value: "\(totalReps)", label: "Total Reps")
                        StatChip(value: "\(streak)🔥", label: "Day Streak")
                    }
                    .padding(.horizontal)

                    // MARK: Recent Activity
                    if !recentSessions.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Recent Activity")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal)

                            VStack(spacing: 8) {
                                ForEach(recentSessions) { session in
                                    RecentSessionCard(session: session)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    // MARK: Quick Start
                    if let drillType = lastDrillType {
                        QuickStartButton(drillType: drillType)
                            .padding(.horizontal)
                    }

                    Spacer(minLength: 40)
                }
            }
        }
    }
}

// MARK: - StatChip

private struct StatChip: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(Color.white.opacity(0.15))
        .cornerRadius(14)
    }
}

// MARK: - RecentSessionCard

private struct RecentSessionCard: View {
    let session: SessionRecord

    private var timeAgoString: String {
        let diff = Date().timeIntervalSince(session.date)
        if diff < 60 { return "Just now" }
        if diff < 3600 { return "\(Int(diff / 60))m ago" }
        if diff < 86400 { return "\(Int(diff / 3600))h ago" }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: session.date)
    }

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: session.drillIcon)
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 2) {
                Text(session.drillDisplayName)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Text("\(session.repsCompleted)/\(session.totalReps) reps · \(session.formattedTime)")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }

            Spacer()

            Text(timeAgoString)
                .font(.caption2)
                .foregroundColor(.white.opacity(0.55))
        }
        .padding(12)
        .background(Color.white.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - QuickStartButton

private struct QuickStartButton: View {
    let drillType: String

    @State private var showColorCall = false
    @State private var showNumberCall = false
    @State private var showDirectionCall = false

    private var drillName: String {
        switch drillType {
        case "colorCall": return "Color Call"
        case "numberCall": return "Number Call"
        case "directionCall": return "Direction Call"
        default: return "Last Drill"
        }
    }

    var body: some View {
        Button(action: { launchDrill() }) {
            HStack {
                Image(systemName: "bolt.fill")
                Text("Jump back into \(drillName)")
                    .fontWeight(.semibold)
            }
            .foregroundColor(Color(red: 0.0, green: 0.1, blue: 0.7))
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(14)
        }
        .sheet(isPresented: $showColorCall) {
            NavigationStack { ColorCallSetupView() }
        }
        .sheet(isPresented: $showNumberCall) {
            NavigationStack { NumberCallSetupView() }
        }
        .sheet(isPresented: $showDirectionCall) {
            NavigationStack { DirectionCallSetupView() }
        }
    }

    private func launchDrill() {
        switch drillType {
        case "colorCall": showColorCall = true
        case "numberCall": showNumberCall = true
        case "directionCall": showDirectionCall = true
        default: break
        }
    }
}

#Preview {
    HomePage()
}
