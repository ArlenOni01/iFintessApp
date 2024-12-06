//
//  Image.swift
//  TrainingApp
//
//  Created by Arlen Oni on 12/5/23.
//

import SwiftUI

struct MyImage: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
}

struct FullWorkList: Identifiable, Hashable {
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
}

struct SpecificList: Identifiable, Hashable {
    let id = UUID()
    let vidName: String
    let workoutName: String
    let wkDescription: String
    var isFaved: Bool
}

struct ImageList {
    
    static let mobilityImages: [FullWorkList] = [
        .init(imageName: "ankle", title: "Ankle", description: "Best ways to reduce shock absorbed elsewhere in the body."),
        .init(imageName: "calisthenics", title: "Calisthenics", description: "Improve your overall balance, posture, and felxibility."),
        .init(imageName: "hips", title: "Hip", description: "Best ways to improve athletic performance and decrease lower back pain."),
        .init(imageName: "knee", title: "Knee", description: "Extend your longevity for daily living activities in these ways."),
        .init(imageName: "lowerLeg", title: "Lower Leg", description: "Improve your ability to stand, move, and keep balance."),
        .init(imageName: "shoulders", title: "Shoulder", description: "Increase your ability to lift things above your head."),
        .init(imageName: "wrist", title: "Wrist", description: "Increase your ability to grip, twist, and lift with these exercises."),
        .init(imageName: "yoga", title: "Yoga", description: "Improve your range of motion and reduce muscle tension.")
    ]
    
    
    static let drillImages: [FullWorkList] = [
        .init(imageName: "cones", title: "Cone Drills", description: "Increase your ability to change direction with reduced effort."),
        .init(imageName: "core", title: "Core Strength", description: "Improve balance and stability with these exercises."),
        .init(imageName: "explosiveness", title: "Explosiveness", description: "Increase the momentum that comes out of each step."),
        .init(imageName: "ladders", title: "Ladder Drills", description: "Improve coordination, balance, and speed."),
        .init(imageName: "lowerBody", title: "Lower Body", description: "Increase longevity for strength and durability of legs."),
        .init(imageName: "upperBody", title: "Upper Body", description: "Decrease stiffness in your body to allow for wider range of motion.")
    ]
    
}

