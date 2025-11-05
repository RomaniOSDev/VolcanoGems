//
//  QuizResultView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI

struct QuizResultView: View {
    let correctAnswers: Int
    let totalQuestions: Int
    let onRestart: () -> Void
    let onBackToMenu: () -> Void
    
    var score: Int {
        Int((Double(correctAnswers) / Double(totalQuestions)) * 100)
    }
    
    var body: some View {
        ZStack {
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("QUIZ RESULTS")
                    .foregroundStyle(.white)
                    .font(.system(size: 45, weight: .heavy, design: .monospaced))
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                // Score display
                VStack(spacing: 20) {
                    Text("\(score)%")
                        .foregroundStyle(.white)
                        .font(.system(size: 80, weight: .bold, design: .monospaced))
                    
                    Text("\(correctAnswers) / \(totalQuestions)")
                        .foregroundStyle(.white)
                        .font(.system(size: 30, weight: .semibold, design: .monospaced))
                }
                
                Spacer()
                
                // Buttons
                VStack(spacing: 20) {
                    Button {
                        onRestart()
                    } label: {
                        Text("TRY AGAIN")
                            .foregroundStyle(.white)
                            .font(.system(size: 25, weight: .bold, design: .monospaced))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.blue.opacity(0.7))
                            )
                    }
                    
                    Button {
                        onBackToMenu()
                    } label: {
                        Text("BACK TO MENU")
                            .foregroundStyle(.white)
                            .font(.system(size: 25, weight: .bold, design: .monospaced))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.gray.opacity(0.7))
                            )
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .padding()
        }
    }
}

