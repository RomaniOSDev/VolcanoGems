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
                Image(correctAnswers == totalQuestions ? .victoryLabel : .lossLabel)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("\(correctAnswers) / \(totalQuestions)")
                        .foregroundStyle(.white)
                        .font(.system(size: 25, weight: .semibold, design: .monospaced))
                
                Spacer()
                
                Image(correctAnswers == totalQuestions ? .victoryCup : .loosCup)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
                
                // Buttons
                VStack(spacing: 20) {
                    Button {
                        onRestart()
                    } label: {
                        MainButtonView(title: "TRY AGAIN")
                    }
                    
                    Button {
                        onBackToMenu()
                    } label: {
                        MainButtonView(title: "BACK TO MENU")
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .padding()
        }
    }
}


#Preview {
    QuizResultView(correctAnswers: 2, totalQuestions: 2) {
        ()
    } onBackToMenu: {
        ()
    }

}
