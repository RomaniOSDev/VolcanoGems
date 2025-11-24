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
                
                Image(won ? .victoryCup : .loosCup)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text(won ? "Great job!" : "Try again!")
                    .foregroundStyle(.white)
                    .font(.system(size: 30, weight: .semibold, design: .monospaced))
                
                Spacer()
                
                // Buttons
                VStack(spacing: 20) {
                    Button {
                        onTryAgain()
                    } label: {
                        MainButtonView(title: "TRY AGAIN")
                        
                    }
                    
                    Button {
                        onBackToLevels()
                    } label: {
                        MainButtonView(title: "BACK TO LEVELS")

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
    MemoryResultView(won: true) {
        ()
    } onBackToLevels: {
        ()
    }

}

