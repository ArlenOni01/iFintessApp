//
//  LadderAnimationView.swift
//  TrainingApp
//
//  Created by Arlen Oni on 9/8/26.
//

import SwiftUI

/// Animates a foot (or feet) stepping down a vertical agility ladder,
/// looping continuously as a movement guide.
struct LadderAnimationView: View {
    let pattern: LadderPattern
    var accentColor: Color = .orange

    @State private var stepIndex = 0

    private let stepDuration: Double = 0.5
    private let holdDuration: Double = 0.2

    private var currentStep: LadderStep { pattern.steps[stepIndex] }

    /// The most recent step (searching backward, wrapping around) that
    /// placed `side`. Since patterns place one side at a time, this is each
    /// foot's own last-known spot — so each foot's marker only moves when
    /// that foot actually takes a step, straight up the ladder, never
    /// sideways toward the other foot's lane.
    private func mostRecentStep(for side: FootSide) -> LadderStep {
        var i = stepIndex
        while true {
            let step = pattern.steps[i]
            if step.placements.contains(where: { $0.foot == side }) {
                return step
            }
            i = (i - 1 + pattern.steps.count) % pattern.steps.count
        }
    }

    var body: some View {
        VStack(spacing: 10) {
            GeometryReader { geo in
                let width = geo.size.width
                let height = geo.size.height
                let squareHeight = height / CGFloat(pattern.squareCount)
                // Keep each rung an even square: the lane is only as wide as
                // a square is tall, centered in the available width.
                let laneWidth = min(squareHeight, width * 0.9)
                let railInset = (width - laneWidth) / 2
                let squareCenterY = (CGFloat(currentStep.squareIndex) + 0.5) * squareHeight
                let railLineWidth = laneWidth * 0.06

                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(accentColor.opacity(0.12))
                        .frame(width: laneWidth, height: squareHeight)
                        .position(x: width / 2, y: squareCenterY)
                        .animation(.easeInOut(duration: stepDuration), value: stepIndex)

                    LadderShape(squareCount: pattern.squareCount)
                        .stroke(Color(.systemGray2), style: StrokeStyle(lineWidth: railLineWidth, lineCap: .round))
                        .padding(.horizontal, railInset)

                    // One marker per foot, each tracking only its own most
                    // recent placement — so every marker travels straight up
                    // its own lane, never diagonally toward the other foot.
                    ForEach(FootSide.allCases, id: \.self) { side in
                        let step = mostRecentStep(for: side)
                        if let placement = step.placements.first(where: { $0.foot == side }) {
                            let isActive = currentStep.placements.contains { $0.foot == side }
                            Ellipse()
                                .fill(accentColor.opacity(isActive ? 1 : 0.35))
                                .frame(width: laneWidth * 0.3, height: squareHeight * 0.72)
                                .position(
                                    x: railInset + laneWidth * (0.5 + placement.xOffset),
                                    y: (CGFloat(step.squareIndex) + 0.5) * squareHeight
                                )
                                .animation(.easeInOut(duration: stepDuration), value: stepIndex)
                        }
                    }
                }
            }

            Text(currentStep.action)
                .font(.caption)
                .fontWeight(.semibold)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(.ultraThinMaterial, in: Capsule())
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.green.opacity(0.12)))
        .task {
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: UInt64((stepDuration + holdDuration) * 1_000_000_000))
                withAnimation(.easeInOut(duration: stepDuration)) {
                    stepIndex = (stepIndex + 1) % pattern.steps.count
                }
            }
        }
    }
}

/// Two vertical rails with evenly spaced rungs, like a real agility ladder
/// viewed flat from above.
private struct LadderShape: Shape {
    let squareCount: Int

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

        let squareHeight = rect.height / CGFloat(squareCount)
        for i in 0...squareCount {
            let y = rect.minY + CGFloat(i) * squareHeight
            path.move(to: CGPoint(x: rect.minX, y: y))
            path.addLine(to: CGPoint(x: rect.maxX, y: y))
        }
        return path
    }
}

#Preview {
    LadderAnimationView(pattern: .oneFoot)
        .frame(height: 340)
        .padding()
}
