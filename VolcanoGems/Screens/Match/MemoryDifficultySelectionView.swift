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
                        Image(difficulty.buttonImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .padding(.horizontal, 40)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}



