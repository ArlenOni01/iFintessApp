//
//  HistoryPage.swift
//  TrainingApp
//
//  Created by Arlen Oni on 6/26/26.
//

import SwiftUI
import SwiftData

struct HistoryPage: View {
    @Query(sort: \SessionRecord.date, order: .reverse) private var sessions: [SessionRecord]

    private var groupedSessions: [(String, [SessionRecord])] {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        var groups: [(String, [SessionRecord])] = []
        var seen: [String: Int] = [:]
        for session in sessions {
            let key = formatter.string(from: session.date)
            if let idx = seen[key] {
                groups[idx].1.append(session)
            } else {
                seen[key] = groups.count
                groups.append((key, [session]))
            }
        }
        return groups
    }

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.teal.opacity(0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)

            VStack {
                Text("History")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                if sessions.isEmpty {
                    Spacer()
                    VStack(spacing: 16) {
                        Image(systemName: "clock")
                            .font(.system(size: 60))
                            .foregroundColor(.secondary)
                        Text("No sessions yet")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text("Complete a drill to see your history here.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    Spacer()
                } else {
                    List {
                        ForEach(groupedSessions, id: \.0) { dateLabel, daySessions in
                            Section(header: Text(dateLabel)) {
                                ForEach(daySessions) { session in
                                    SessionRow(session: session)
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .padding(.horizontal)
        }
    }
}

private struct SessionRow: View {
    let session: SessionRecord

    private var timeString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: session.date)
    }

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: session.drillIcon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(Color(red: 0.0, green: 0.1, blue: 0.7))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 3) {
                Text(session.drillDisplayName)
                    .fontWeight(.semibold)
                HStack(spacing: 8) {
                    Text("\(session.repsCompleted)/\(session.totalReps) reps")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("·")
                        .foregroundColor(.secondary)
                    Text(session.formattedTime)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    if let avg = session.formattedAvgReaction {
                        Text("·")
                            .foregroundColor(.secondary)
                        Text(avg + " avg")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }

            Spacer()

            Text(timeString)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    HistoryPage()
}
