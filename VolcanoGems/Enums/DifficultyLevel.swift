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
    var buttonImage: ImageResource {
        switch self {
        case .easy:
            return .easyBrainBTN
        case .medium:
            return .mediumBrainBTN
        case .hard:
            return .hardBrainBtn
        }
    }
    var difficultyLabe: ImageResource{
        switch self {
        case .easy:
            return .easyLabel
        case .medium:
            return .mediumLabal
        case .hard:
            return .hardLAbel
        }
    }
}


