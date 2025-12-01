//
//  BrainView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI

enum QuizScreen {
    case difficultySelection
    case quiz
    case results
}

struct BrainView: View {
    @StateObject private var statisticsManager = GameStatisticsManager.shared
    @StateObject private var achievementManager = AchievementManager.shared
    @State private var currentScreen: QuizScreen = .difficultySelection
    @State private var selectedDifficulty: DifficultyLevel?
    @State private var quizQuestions: [QuizQuestion] = []
    @State private var quizResults: (correct: Int, total: Int)?
    
    var body: some View {
        ZStack {
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            
            switch currentScreen {
            case .difficultySelection:
                DifficultySelectionView { difficulty in
                    selectedDifficulty = difficulty
                    quizQuestions = QuizData.shared.questions(for: difficulty)
                    currentScreen = .quiz
                }
                
            case .quiz:
                if let difficulty = selectedDifficulty {
                    QuizView(
                        difficulty: difficulty,
                        questions: quizQuestions
                    ) { correct, total in
                        quizResults = (correct, total)
                        // Save statistics
                        let won = correct == total
                        statisticsManager.recordBrainGame(won: won)
                        
                        // Update achievements after statistics are saved
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            // Always update first quiz achievement (completing any quiz)
                            achievementManager.updateFirstQuiz()
                            
                            // Update quiz wins if won
                            if won {
                                let currentWins = statisticsManager.statistics.brainWins
                                achievementManager.updateQuizWins(currentWins)
                            }
                            
                            // Update perfect score achievement
                            if correct == total {
                                achievementManager.updatePerfectScore()
                            }
                            
                            // Update hard mode achievement
                            if let difficulty = selectedDifficulty, difficulty == .hard {
                                let hardModeCount = UserDefaults.standard.integer(forKey: "hard_mode_quizzes")
                                UserDefaults.standard.set(hardModeCount + 1, forKey: "hard_mode_quizzes")
                                achievementManager.updateHardModeQuizzes(hardModeCount + 1)
                            }
                            
                            // Update total games achievement (any game completion)
                            let totalGames = statisticsManager.statistics.brainTotalGames + statisticsManager.statistics.matchTotalGames
                            achievementManager.updateTotalGames(totalGames)
                        }
                        
                        currentScreen = .results
                    }
                }
                
            case .results:
                if let results = quizResults {
                    QuizResultView(
                        correctAnswers: results.correct,
                        totalQuestions: results.total
                    ) {
                        // Try again - restart quiz with same difficulty
                        if let difficulty = selectedDifficulty {
                            quizQuestions = QuizData.shared.questions(for: difficulty)
                            currentScreen = .quiz
                        }
                    } onBackToMenu: {
                        // Back to difficulty selection
                        currentScreen = .difficultySelection
                        selectedDifficulty = nil
                        quizResults = nil
                    }
                }
            }
        }
    }
}

#Preview {
    BrainView()
}
