//
//  ReadQuotes.swift
//  TrainingApp
//
//  Created by Arlen Oni on 9/23/24.
//

import Foundation

func loadQuotesFromCSV() -> [AnimeQuote] {
    guard let path = Bundle.main.path(forResource: "AnimeQuotes", ofType: "csv") else {
        return []
    }

    do {
        let data = try String(contentsOfFile: path)
        var quotes = [AnimeQuote]()

        // Split the CSV data into rows
        let rows = data.components(separatedBy: "\n")
        
        // Iterate over the rows and split into columns
        for row in rows {
            let columns = row.components(separatedBy: ",")
            
            if columns.count == 3 { // Assuming the CSV has 2 columns
                let quote = columns[0]
                let character = columns[1]
                let anime = columns[2]
                quotes.append(AnimeQuote(quote: quote, character: character, anime: anime))
            }
        }

        return quotes
    } catch {
        print("Error loading CSV file: \(error)")
        return []
    }
}
