//
//  SplashScreen.swift
//  Football Daily
//
//  Created by Thomas Mani on 24/07/24.
//

import SwiftUI

struct SplashScreen: View {
    
    // MARK: State variables
    @State var isFavTeamSelected: Bool = false
    
    init() {
        if UserDefaults.standard.string(forKey: "favTeam") != nil {
            isFavTeamSelected = true
        }
    }
    
    var body: some View {
        if isFavTeamSelected {
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
            .onAppear(perform: {
                Task {
                    await APIManager().sendRequest(endpoint: Endpoints.countries.rawValue) { (result: Result<CountriesResponse, Error>) in
                        switch result {
                        case .success(let response):
                            print(response)
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            })
        }
    }
}

#Preview {
    SplashScreen()
}
