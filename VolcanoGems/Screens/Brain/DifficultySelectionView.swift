//
//  DifficultySelectionView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI

struct DifficultySelectionView: View {
    let onDifficultySelected: (DifficultyLevel) -> Void
    
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
                
                ForEach(DifficultyLevel.allCases, id: \.self) { difficulty in
                    Button {
                        onDifficultySelected(difficulty)
                    } label: {
                        Text(difficulty.rawValue)
                            .foregroundStyle(.white)
                            .font(.system(size: 35, weight: .bold, design: .monospaced))
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

