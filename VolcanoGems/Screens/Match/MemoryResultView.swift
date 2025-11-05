//
//  MemoryResultView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI

struct MemoryResultView: View {
    let won: Bool
    let onTryAgain: () -> Void
    let onBackToLevels: () -> Void
    
    var body: some View {
        ZStack {
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text(won ? "LEVEL COMPLETE!" : "LEVEL FAILED")
                    .foregroundStyle(.white)
                    .font(.system(size: 45, weight: .heavy, design: .monospaced))
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Image(systemName: won ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundStyle(won ? .green : .red)
                    .font(.system(size: 100))
                
                Text(won ? "Great job!" : "Try again!")
                    .foregroundStyle(.white)
                    .font(.system(size: 30, weight: .semibold, design: .monospaced))
                
                Spacer()
                
                // Buttons
                VStack(spacing: 20) {
                    Button {
                        onTryAgain()
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
                        onBackToLevels()
                    } label: {
                        Text("BACK TO LEVELS")
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

