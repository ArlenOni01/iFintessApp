//
//  MobWorkouts.swift
//  TrainingApp
//
//  Created by Arlen Oni on 12/5/23.
//

import SwiftUI

struct WorkoutList {
    static let ankleWork: [SpecificList] = [
        .init(vidName: "ankle", workoutName: "Ankle Flexion", wkDescription: "Kneel down and press ankle humps into the floor.", isFaved: false),
        .init(vidName: "ankle", workoutName: "Heel lifts", wkDescription: "Keep heels on ground and lift up toes towards the ceiling.", isFaved: false),
        .init(vidName: "ankle", workoutName: "Ankle Rotations", wkDescription: "Lift knee to 90 degrees and and rotate clockwise and counter-clockwise with ankles pointing down and twisting upwards.", isFaved: false)
        
    ]
    
    static let calisthenicWork: [SpecificList] = [
        .init(vidName: "calisthenics", workoutName: "Pull Ups", wkDescription: "Just pull up on the bar.", isFaved: false)
    ]
    
    static let hipWork: [SpecificList] = [
        .init(vidName: "hips", workoutName: "Hip Abduction", wkDescription: "Use the machine.", isFaved: false)
    ]
    
    static let kneeWork: [SpecificList] = [
        .init(vidName: "knee", workoutName: "Cycling", wkDescription: "Kneel down and press ankle humps into the floor.", isFaved: false)
    ]
    
    static let lowerLegWork: [SpecificList] = [
        .init(vidName: "lowerLeg", workoutName: "Single Legged Hops", wkDescription: "Kneel down and press ankle humps into the floor.", isFaved: false)
    ]
    
    static let shoulderWork: [SpecificList] = [
        .init(vidName: "shoulders", workoutName: "Shoulder Cuff rotations", wkDescription: "Kneel down and press ankle humps into the floor.", isFaved: false)
    ]
    
    static let wristWork: [SpecificList] = [
        .init(vidName: "wrist", workoutName: "Wrist Flexion", wkDescription: "Kneel down and press ankle humps into the floor.", isFaved: false)
    ]
    
    static let yogaWork: [SpecificList] = [
        .init(vidName: "yoga", workoutName: "Downward Dog", wkDescription: "Kneel down and press ankle humps into the floor.", isFaved: false)
    ]
}
