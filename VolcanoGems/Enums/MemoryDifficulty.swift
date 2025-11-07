//
//  MemoryDifficulty.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import Foundation

enum MemoryDifficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    var gridSize: (rows: Int, columns: Int) {
        switch self {
        case .easy:
            return (2, 3)  // 2x3 = 6 карточек, 3 пары
        case .medium:
            return (3, 3)  // 3x3 = 9 ячеек, используем 8 карточек (4 пары)
        case .hard:
            return (4, 4)  // 4x4 = 16 карточек, 8 пар
        }
    }
    
    var totalPairs: Int {
        switch self {
        case .easy:
            return 3  // 2x3 = 6 карточек, 3 пары
        case .medium:
            return 4  // 3x3 = 9 ячеек, но используем 8 карточек (4 пары)
        case .hard:
            return 8  // 4x4 = 16 карточек, 8 пар
        }
    }
    
    var initialTime: Int {
        return 60  // 60 секунд на первом уровне
    }
    
    func timeForLevel(_ level: Int) -> Int {
        return initialTime - (level - 1) * 5  // Уменьшается на 5 секунд каждый уровень
    }
    var buttonImage: ImageResource {
        switch self {
        case .easy:
            return .easyModeBTN
        case .medium:
            return .mediumModeBTN
        case .hard:
            return .hardModeBTN
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

