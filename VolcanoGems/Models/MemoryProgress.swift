//
//  MemoryProgress.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import Foundation
import Combine

class MemoryProgressManager: ObservableObject {
    static let shared = MemoryProgressManager()
    
    private let userDefaults = UserDefaults.standard
    private let easyKey = "memory_easy_levels"
    private let mediumKey = "memory_medium_levels"
    private let hardKey = "memory_hard_levels"
    
    private init() {}
    
    func getUnlockedLevels(for difficulty: MemoryDifficulty) -> Set<Int> {
        let key: String
        switch difficulty {
        case .easy:
            key = easyKey
        case .medium:
            key = mediumKey
        case .hard:
            key = hardKey
        }
        
        if let array = userDefaults.array(forKey: key) as? [Int] {
            let levels = Set(array)
            // Убеждаемся, что уровень 1 всегда открыт
            if levels.isEmpty {
                var newLevels = [1]
                userDefaults.set(newLevels, forKey: key)
                return Set(newLevels)
            }
            return levels
        }
        // Первый запуск - инициализируем уровень 1
        let initialLevels = [1]
        userDefaults.set(initialLevels, forKey: key)
        return Set(initialLevels)
    }
    
    func unlockLevel(_ level: Int, for difficulty: MemoryDifficulty) {
        let key: String
        switch difficulty {
        case .easy:
            key = easyKey
        case .medium:
            key = mediumKey
        case .hard:
            key = hardKey
        }
        
        var unlocked: Set<Int>
        if let array = userDefaults.array(forKey: key) as? [Int] {
            unlocked = Set(array)
        } else {
            unlocked = [1]  // Первый уровень всегда открыт
        }
        
        unlocked.insert(level)
        userDefaults.set(Array(unlocked), forKey: key)
    }
    
    func resetProgress(for difficulty: MemoryDifficulty) {
        let key: String
        switch difficulty {
        case .easy:
            key = easyKey
        case .medium:
            key = mediumKey
        case .hard:
            key = hardKey
        }
        
        userDefaults.removeObject(forKey: key)
    }
}

