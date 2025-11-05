//
//  SettingsView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @State private var terms = "https://google.com"
    @State private var privacy = "https://google.com"
    var body: some View {
        ZStack{
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text("SETTINGS")
                    .foregroundStyle(.white)
                    .font(.system(size: 45, weight: .heavy, design: .monospaced))
                
                Spacer()
                //MARK: - Terms button
                Button {
                    if let url = URL(string: terms) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    MainButtonView(title: "TERMS OF USE")
                }
                
                //MARK: - Policy button
                Button {
                    if let url = URL(string: privacy) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    MainButtonView(title: "PRIVACY POLICY")
                }
                
                //MARK: - rate button
                Button {
                    SKStoreReviewController.requestReview()
                } label: {
                    MainButtonView(title: "RATE US")
                }
Spacer()
            }.padding()
                
        }
        
        
    }
}

#Preview {
    SettingsView()
}
