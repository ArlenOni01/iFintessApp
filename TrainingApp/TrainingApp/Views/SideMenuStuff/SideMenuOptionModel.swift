//
//  SideMenuOptionModel.swift
//  TrainingApp
//
//  Created by Arlen Oni on 11/4/24.
//

import Foundation

enum SideMenuOptionModel: Int, CaseIterable {
    case Home
    case Train
    case Mobility

    var systemImageName: String {
        switch self {
        case .Home: return "house"
        case .Train: return "flag.checkered"
        case .Mobility: return "figure.flexibility"
        }
    }

    var title: String {
        switch self {
        case .Home: return "Home"
        case .Train: return "Train"
        case .Mobility: return "Mobility"
        }
    }
}

extension SideMenuOptionModel: Identifiable {
    var id: Int { return self.rawValue }
}
