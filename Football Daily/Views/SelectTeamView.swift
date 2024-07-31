//
//  selectTeamView.swift
//  Football Daily
//
//  Created by Thomas Mani on 24/07/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct SelectTeamView: View {
    
    @Binding var isFavTeamSelected: Bool
    @State var isLoading: Bool = false
    @State var isCountrySelected: Bool = false
    @ObservedObject var viewModel: SelectTeamViewModel = SelectTeamViewModel()
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
            VStack {
                
                Text("Selected Country")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                    .padding(.bottom, 30)
                
        
                if viewModel.selectedCountry != nil {
                    WebImage(url: URL(string: viewModel.selectedCountry?.flag ?? ""), context: [.imageThumbnailPixelSize: CGSize.zero])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, alignment: .center)
                        .shadow(color: .black, radius: 2)
                        .border(Color.black, width: 1)
                    
                    Text(viewModel.selectedCountry?.name ?? "")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundStyle(.white)
                }
                
                Spacer()
                
                if isCountrySelected {
                    Picker("League", selection: $viewModel.selectedCountry) {
                        ForEach(viewModel.countriesList, id: \.id) { country in
                                Text(country.name ?? "")
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.white)
                                    .tag(country as? Country)
                        }
                    }
                    .padding(.bottom, 30)
                } else {
                    Picker("Country", selection: $viewModel.selectedCountry) {
                        ForEach(viewModel.countriesList, id: \.id) { country in
                                Text(country.name ?? "")
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.white)
                                    .tag(country as? Country)
                        }
                    }
                    .padding(.bottom, 30)
                }
                
                Button("Next") {
                    if viewModel.selectedCountry != nil {
                        isCountrySelected = true
                    }
                }
                .padding()
                .font(.system(size: 20))
                .fontWeight(.bold)
                .fontDesign(.rounded)
                .foregroundStyle(.white)
                .background(Color(red: 0, green: 0.25, blue: 0.25))
                .clipShape(Capsule())
            }
            .blur(radius: isLoading ? 5 : 0)
            .allowsHitTesting(!isLoading)
            
            if isLoading {
                LoadingView()
            }
        }
        .background(
            .linearGradient(
                .init(colors: [.blue,.black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing))
        .onAppear(perform: {
            Task {
                isLoading = true
                await viewModel.getCountries()
                isLoading = false
            }
        })
    }
}

#Preview {
    SelectTeamView(isFavTeamSelected: .constant(false))
}
