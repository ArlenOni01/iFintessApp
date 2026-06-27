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
    case History

    var systemImageName: String {
        switch self {
        case .Home: return "house"
        case .Train: return "flag.checkered"
        case .Mobility: return "figure.flexibility"
        case .History: return "clock"
        }
    }

    var title: String {
        switch self {
        case .Home: return "Home"
        case .Train: return "Train"
        case .Mobility: return "Mobility"
        case .History: return "History"
        }
    }
}

extension SideMenuOptionModel: Identifiable {
    var id: Int { return self.rawValue }
}
