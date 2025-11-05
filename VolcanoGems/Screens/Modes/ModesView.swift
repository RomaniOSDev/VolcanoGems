//
//  ModesView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI

struct ModesView: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        ZStack{
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text("MODES")
                    .foregroundStyle(.white)
                    .font(.system(size: 45, weight: .heavy, design: .monospaced))
                
                Spacer()
                //MARK: - Brain button
                Button {
                    navigationManager.navigate(to: .brain)
                } label: {
                    Image(.brainRTNLabel)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                //MARK: - Facts button
                Button {
                    navigationManager.navigate(to: .facts)
                } label: {
                    Image(.factBTNLabel)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                //MARK: - Match button
                Button {
                    navigationManager.navigate(to: .math)
                } label: {
                    Image(.matchBTNLabel)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
Spacer()
            }.padding()
                
        }
    }
}

#Preview {
    ModesView()
}
