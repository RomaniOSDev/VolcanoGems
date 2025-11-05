//
//  StartView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI

struct StartView: View {
    
    @State private var radiusShadow = false
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        ZStack {
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            VStack {
                //MARK: - Setting button
                HStack {
                    Spacer()
                    Button {
                        navigationManager.navigate(to: .settings)
                    } label: {
                        Image(.settingsBTNLabel)
                            .resizable()
                            .frame(width: 60, height: 60)
                    }

                }
                
                //MARK: - Logo
                Image(.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
                
                //MARK: - Start Button
                Button {
                    navigationManager.navigate(to: .mades)
                } label: {
                    Image(.startbtNLAbel)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(color: .yellow, radius: radiusShadow ? 5 : 15)
                }
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                        radiusShadow.toggle()
                    }
                    
                }
                .animation(.easeInOut, value: radiusShadow)

            }.padding()
        }
    }
}

#Preview {
    StartView()
}
