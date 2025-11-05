//
//  DifficultyLevel.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import Foundation

enum DifficultyLevel: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    var questionRange: ClosedRange<Int> {
        switch self {
        case .easy:
            return 1...10
        case .medium:
            return 11...20
        case .hard:
            return 21...30
        }
    }
}

