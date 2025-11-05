//
//  QuizView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI

struct QuizView: View {
    let difficulty: DifficultyLevel
    let questions: [QuizQuestion]
    let onQuizComplete: (Int, Int) -> Void
    
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswerIndex: Int? = nil
    @State private var correctAnswers = 0
    
    var currentQuestion: QuizQuestion {
        questions[currentQuestionIndex]
    }
    
    var progress: Double {
        Double(currentQuestionIndex + 1) / Double(questions.count)
    }
    
    var body: some View {
        ZStack {
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Progress bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.gray.opacity(0.3))
                        
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.blue)
                            .frame(width: geometry.size.width * progress)
                    }
                }
                .frame(height: 10)
                .padding(.horizontal)
                
                // Question number
                Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .semibold, design: .monospaced))
                
                Spacer()
                
                // Question text
                Text(currentQuestion.question)
                    .foregroundStyle(.white)
                    .font(.system(size: 28, weight: .bold, design: .monospaced))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
                // Answer options
                VStack(spacing: 15) {
                    ForEach(Array(currentQuestion.options.enumerated()), id: \.offset) { index, option in
                        Button {
                            if selectedAnswerIndex == nil {
                                selectedAnswerIndex = index
                                if index == currentQuestion.correctAnswerIndex {
                                    correctAnswers += 1
                                }
                                
                                // Move to next question after delay
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    moveToNextQuestion()
                                }
                            }
                        } label: {
                            HStack {
                                Text(option)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 22, weight: .medium, design: .monospaced))
                                
                                Spacer()
                                
                                if let selected = selectedAnswerIndex {
                                    if selected == index {
                                        Image(systemName: index == currentQuestion.correctAnswerIndex ? "checkmark.circle.fill" : "xmark.circle.fill")
                                            .foregroundStyle(index == currentQuestion.correctAnswerIndex ? .green : .red)
                                    } else if index == currentQuestion.correctAnswerIndex {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundStyle(.green)
                                    }
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(backgroundColor(for: index))
                            )
                        }
                        .disabled(selectedAnswerIndex != nil)
                        .padding(.horizontal)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .onAppear {
            // Reset state when view appears
            currentQuestionIndex = 0
            selectedAnswerIndex = nil
            correctAnswers = 0
        }
    }
    
    private func backgroundColor(for index: Int) -> Color {
        guard let selected = selectedAnswerIndex else {
            return Color.blue.opacity(0.6)
        }
        
        if index == currentQuestion.correctAnswerIndex {
            return Color.green.opacity(0.7)
        } else if selected == index {
            return Color.red.opacity(0.7)
        }
        
        return Color.blue.opacity(0.6)
    }
    
    private func moveToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswerIndex = nil
        } else {
            // Quiz completed
            onQuizComplete(correctAnswers, questions.count)
        }
    }
}

