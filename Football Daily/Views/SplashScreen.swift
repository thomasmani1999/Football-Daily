//
//  SplashScreen.swift
//  Football Daily
//
//  Created by Thomas Mani on 24/07/24.
//

import SwiftUI

struct SplashScreen: View {
    
    // MARK: State variables
    @State var favTeamNotSelected: Bool = true
    
    init() {
        if UserDefaults.standard.string(forKey: "favTeam") != nil {
            favTeamNotSelected = false
        }
    }
    
    var body: some View {
        if !favTeamNotSelected {
            ContentView()
        } else {
            ZStack(content: {
                Rectangle()
                    .fill(.white)
                    .background(Color.white)
                    
                HStack(alignment: .top, spacing: 10, content: {
                    
                    Image("football")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height:80)
                    VStack(alignment: .leading, spacing: -13, content: {
                        Text("Football")
                            .foregroundStyle(.black)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Daily")
                            .foregroundStyle(.black)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    })
                })
            })
            .fullScreenCover(isPresented: $favTeamNotSelected, content: {
                SelectTeamView(isFavTeamSelected: $favTeamNotSelected)
            })
        }
    }
}

#Preview {
    SplashScreen()
}
