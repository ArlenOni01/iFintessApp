//
//  SideMenuOptionModel.swift
//  TrainingApp
//
//  Created by Arlen Oni on 11/4/24.
//

import Foundation

enum SideMenuOptionModel: Int, CaseIterable {
    case Home
    case Nutrition
    case Timer
    case Drills
    case Games
    
    var systemImageName: String {
        switch self {
        case .Home: return "house"
        case .Nutrition: return "fork.knife"
        case .Timer: return "timer"
        case .Drills: return "flag.checkered"
        case .Games: return "gamecontroller"
        }
    }
    
    var title: String {
        switch self {
        case .Home: return "Home"
        case .Nutrition: return "Nutrition"
        case .Timer: return "Timer"
        case .Drills: return "Drills"
        case .Games: return "Games"
        }
    }
}

extension SideMenuOptionModel: Identifiable {
    var id: Int { return self.rawValue }
}
