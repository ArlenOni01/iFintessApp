//
//  DrillWorkouts.swift
//  TrainingApp
//
//  Created by Arlen Oni on 12/7/23.
//

import SwiftUI

struct DrillList {
    static let coneDrillWork: [SpecificList] = [
        .init(vidName: "cones", workoutName: "T-Drill", wkDescription: "Follow the following T-drill pattern.", isFaved: false),
        .init(vidName: "cones", workoutName: "Box Drills", wkDescription: "Follow the following box drill patterns.", isFaved: false)
    ]
    
    static let coreStrengthWork: [SpecificList] = [
        .init(vidName: "core", workoutName: "Around the Worlds", wkDescription: "Grab Kettle bell and rotate around your body.", isFaved: false),
    ]
    
    static let explosivenessWork: [SpecificList] = [
        .init(vidName: "explosiveness", workoutName: "Ankle Flexion", wkDescription: "Kneel down and press ankle humps into the floor.", isFaved: false)
    ]
    
    static let ladderWork: [SpecificList] = [
        .init(vidName: "ladders", workoutName: "One Foot", wkDescription: "One foot in each hole on a sprint.", isFaved: false),
        .init(vidName: "ladders", workoutName: "Two Foot", wkDescription: "Kneel down and press ankle humps into the floor.", isFaved: false),
        .init(vidName: "ladders", workoutName: "TypeWriter", wkDescription: "Kneel down and press ankle humps into the floor.", isFaved: false),
        .init(vidName: "ladders", workoutName: "Reverse Typewriter", wkDescription: "Kneel down and press ankle humps into the floor.", isFaved: false),
        .init(vidName: "ladders", workoutName: "Scissors", wkDescription: "Kneel down and press ankle humps into the floor.", isFaved: false)
    ]
    
    static let lowerBodyWork: [SpecificList] = [
        .init(vidName: "lowerBody", workoutName: "Front Squats", wkDescription: "Hold bar on shoulders and keep heels on ground.", isFaved: false),
        .init(vidName: "lowerBody", workoutName: "Heel elevated Goblet Squats", wkDescription: "Elevate heels off the ground with a plate and squat.", isFaved: false)
    ]
    
    static let upperBodyWork: [SpecificList] = [
        .init(vidName: "upperBody", workoutName: "Landmine Rotation", wkDescription: "Rotate standing press overhead side to side.", isFaved: false)
    ]
}

