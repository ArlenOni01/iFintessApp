//
//  MobWorkouts.swift
//  TrainingApp
//
//  Created by Arlen Oni on 12/5/23.
//

import SwiftUI

struct WorkoutList {
    static let ankleWork: [SpecificList] = [
        .init(vidName: "ankle_flexion_start", workoutName: "Ankle Flexion", wkDescription: "Kneel down and press ankle humps into the floor.", isFaved: false, vidName2: "ankle_flexion_finish"),
        .init(vidName: "heel_lifts_start", workoutName: "Heel lifts", wkDescription: "Keep heels on ground and lift up toes towards the ceiling.", isFaved: false, vidName2: "ankle"),
        .init(vidName: "ankle", workoutName: "Ankle Rotations", wkDescription: "Lift knee to 90 degrees and and rotate clockwise and counter-clockwise with ankles pointing down and twisting upwards.", isFaved: false, vidName2: "ankle_rotation_finish")

    ]

    static let calisthenicWork: [SpecificList] = [
        .init(vidName: "pullup_start", workoutName: "Pull Ups", wkDescription: "Just pull up on the bar.", isFaved: false, vidName2: "pullup_finish")
    ]

    static let hipWork: [SpecificList] = [
        .init(vidName: "hips", workoutName: "Hip Abduction", wkDescription: "Use the machine.", isFaved: false, vidName2: "hips")
    ]

    static let kneeWork: [SpecificList] = [
        .init(vidName: "knee", workoutName: "Cycling", wkDescription: "Lie back and pedal an imaginary bike to mobilize the knees.", isFaved: false, vidName2: "knee")
    ]

    static let lowerLegWork: [SpecificList] = [
        .init(vidName: "lowerLeg", workoutName: "Single Legged Hops", wkDescription: "Hop in place on one leg to build lower leg control.", isFaved: false, vidName2: "lowerLeg")
    ]

    static let shoulderWork: [SpecificList] = [
        .init(vidName: "shoulder_cuff_rotation_start", workoutName: "Shoulder Cuff rotations", wkDescription: "Rotate the arm through its full range to mobilize the rotator cuff.", isFaved: false, vidName2: "shoulder_cuff_rotation_finish")
    ]

    static let wristWork: [SpecificList] = [
        .init(vidName: "wrist", workoutName: "Wrist Flexion", wkDescription: "Bend the wrist forward and back through its full range.", isFaved: false, vidName2: "wrist")
    ]

    static let yogaWork: [SpecificList] = [
        .init(vidName: "yoga", workoutName: "Downward Dog", wkDescription: "Form an inverted V, pressing heels toward the floor.", isFaved: false, vidName2: "yoga")
    ]
}
