//
//  MemoryDifficultySelectionView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI

struct MemoryDifficultySelectionView: View {
    let onDifficultySelected: (MemoryDifficulty) -> Void
    
    var body: some View {
        ZStack {
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("SELECT DIFFICULTY")
                    .foregroundStyle(.white)
                    .font(.system(size: 45, weight: .heavy, design: .monospaced))
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                ForEach(MemoryDifficulty.allCases, id: \.self) { difficulty in
                    Button {
                        onDifficultySelected(difficulty)
                    } label: {
                        VStack(spacing: 8) {
                            Text(difficulty.rawValue)
                                .foregroundStyle(.white)
                                .font(.system(size: 35, weight: .bold, design: .monospaced))
                            
                            Text("\(difficulty.gridSize.rows)x\(difficulty.gridSize.columns)")
                                .foregroundStyle(.white.opacity(0.8))
                                .font(.system(size: 20, weight: .medium, design: .monospaced))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.blue.opacity(0.7))
                        )
                    }
                    .padding(.horizontal, 40)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

