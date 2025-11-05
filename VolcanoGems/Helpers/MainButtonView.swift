//
//  MainButtonView.swift
//  VolcanoGems
//
//  Created by Роман Главацкий on 05.11.2025.
//

import SwiftUI

struct MainButtonView: View {
    var title: String
    
    var body: some View {
        ZStack{
            Image(.backForBTN)
                .resizable()
                .aspectRatio(contentMode: .fit)

                Text(title)
                    .foregroundStyle(.white)
                    .font(.system(size: 26, weight: .heavy, design: .monospaced))
            
        }.cornerRadius(20)
    }
}

#Preview {
    MainButtonView(title: "TERMS OF USE")
}
