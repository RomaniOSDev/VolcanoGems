//
//  MatchView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI
import Combine

enum MemoryScreen {
    case difficultySelection
    case levelSelection
    case game
    case result
}

struct MatchView: View {
    @StateObject private var progressManager = MemoryProgressManager.shared
    @State private var currentScreen: MemoryScreen = .difficultySelection
    @State private var selectedDifficulty: MemoryDifficulty?
    @State private var selectedLevel: Int?
    @State private var gameResult: Bool?
    
    var body: some View {
        ZStack {
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            
            switch currentScreen {
            case .difficultySelection:
                MemoryDifficultySelectionView { difficulty in
                    selectedDifficulty = difficulty
                    currentScreen = .levelSelection
                }
                
            case .levelSelection:
                if let difficulty = selectedDifficulty {
                    LevelSelectionView(difficulty: difficulty) { level in
                        selectedLevel = level
                        currentScreen = .game
                    } onBack: {
                        currentScreen = .difficultySelection
                        selectedDifficulty = nil
                    }
                }
                
            case .game:
                if let difficulty = selectedDifficulty, let level = selectedLevel {
                    MemoryGameView(
                        difficulty: difficulty,
                        level: level
                    ) { won in
                        gameResult = won
                        
                        // Save statistics
                        GameStatisticsManager.shared.recordMatchGame(won: won)
                        
                        // Unlock next level if won
                        if won {
                            if level < 6 {
                                progressManager.unlockLevel(level + 1, for: difficulty)
                            }
                        }
                        
                        currentScreen = .result
                    } onBack: {
                        currentScreen = .levelSelection
                    }
                }
                
            case .result:
                if let won = gameResult, let difficulty = selectedDifficulty, let level = selectedLevel {
                    MemoryResultView(won: won) {
                        // Try again - restart game
                        currentScreen = .game
                    } onBackToLevels: {
                        // Back to level selection
                        currentScreen = .levelSelection
                        gameResult = nil
                    }
                }
            }
        }
    }
}

#Preview {
    MatchView()
}
