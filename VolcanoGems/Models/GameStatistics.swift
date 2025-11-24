//
//  GameStatistics.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import Foundation
import Combine

struct GameStatistics: Codable {
    var brainTotalGames: Int = 0
    var brainWins: Int = 0
    var brainLosses: Int = 0
    
    var matchTotalGames: Int = 0
    var matchWins: Int = 0
    var matchLosses: Int = 0
}

class GameStatisticsManager: ObservableObject {
    static let shared = GameStatisticsManager()
    
    @Published var statistics: GameStatistics {
        didSet {
            saveStatistics()
        }
    }
    
    private let userDefaults = UserDefaults.standard
    private let statisticsKey = "game_statistics"
    
    private init() {
        self.statistics = GameStatisticsManager.loadStatistics()
    }
    
    // MARK: - Brain Statistics
    
    func recordBrainGame(won: Bool) {
        statistics.brainTotalGames += 1
        if won {
            statistics.brainWins += 1
        } else {
            statistics.brainLosses += 1
        }
    }
    
    // MARK: - Match Statistics
    
    func recordMatchGame(won: Bool) {
        statistics.matchTotalGames += 1
        if won {
            statistics.matchWins += 1
        } else {
            statistics.matchLosses += 1
        }
    }
    
    // MARK: - Reset
    
    func resetAllStatistics() {
        statistics = GameStatistics()
    }
    
    // MARK: - Persistence
    
    private func saveStatistics() {
        if let encoded = try? JSONEncoder().encode(statistics) {
            userDefaults.set(encoded, forKey: statisticsKey)
        }
    }
    
    private static func loadStatistics() -> GameStatistics {
        let key = "game_statistics"
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode(GameStatistics.self, from: data) else {
            return GameStatistics()
        }
        return decoded
    }
}

