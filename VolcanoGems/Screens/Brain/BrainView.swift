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
