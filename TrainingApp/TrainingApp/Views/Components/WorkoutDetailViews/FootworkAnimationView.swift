//
//  FootworkAnimationView.swift
//  TrainingApp
//
//  Created by Arlen Oni on 9/7/26.
//

import SwiftUI

/// Animates two footprints stepping through a `FootworkPattern` over an
/// 8-cone agility square, looping continuously as a movement guide.
struct FootworkAnimationView: View {
    let pattern: FootworkPattern
    var accentColor: Color = .orange

    @State private var stepIndex = 0

    private let stepDuration: Double = 0.85
    private let holdDuration: Double = 0.45

    private var currentStep: FootworkStep { pattern.steps[stepIndex] }

    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)

            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.green.opacity(0.12))

                ForEach(FootworkGridPoint.allCases, id: \.self) { gridPoint in
                    ConeMarker(isActive: pattern.activeCones.contains(gridPoint))
                        .frame(width: size * 0.05, height: size * 0.06)
                        .position(x: gridPoint.unitPoint.x * size, y: gridPoint.unitPoint.y * size)
                }

                footprint(for: .left, size: size)
                footprint(for: .right, size: size)

                VStack {
                    Spacer()
                    Text(currentStep.action)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(.ultraThinMaterial, in: Capsule())
                }
                .padding(.bottom, size * 0.04)
            }
            .frame(width: size, height: size)
            .frame(maxWidth: .infinity)
            .task {
                while !Task.isCancelled {
                    try? await Task.sleep(nanoseconds: UInt64((stepDuration + holdDuration) * 1_000_000_000))
                    withAnimation(.easeInOut(duration: stepDuration)) {
                        stepIndex = (stepIndex + 1) % pattern.steps.count
                    }
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }

    /// Offsets the lead foot slightly ahead and the trail foot slightly behind
    /// the target cone so both feet stay visible as a landing guide.
    private func footprint(for side: FootSide, size: CGFloat) -> some View {
        let point = currentStep.point.unitPoint
        let isLead = currentStep.leadFoot == side
        let lateral: CGFloat = side == .left ? -size * 0.035 : size * 0.035
        let forward: CGFloat = isLead ? -size * 0.02 : size * 0.02

        return Ellipse()
            .fill(accentColor.opacity(isLead ? 1 : 0.6))
            .frame(width: size * 0.045, height: size * 0.13)
            .position(x: point.x * size + lateral, y: point.y * size + forward)
            .animation(.easeInOut(duration: stepDuration), value: stepIndex)
    }
}

private struct ConeMarker: View {
    let isActive: Bool

    var body: some View {
        ConeShape()
            .fill(isActive ? Color.orange : Color.secondary.opacity(0.3))
            .opacity(isActive ? 1 : 0.5)
            .scaleEffect(isActive ? 1 : 0.55)
    }
}

private struct ConeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    FootworkAnimationView(pattern: .boxDrill)
        .padding()
}
