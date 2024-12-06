//
//  AnimeStruct.swift
//  TrainingApp
//
//  Created by Arlen Oni on 9/23/24.
//

import SwiftUI

struct AnimeQuote: Identifiable {
    var id = UUID() // Unique ID for each quote
    var quote: String
    var character: String
    var anime: String
}
