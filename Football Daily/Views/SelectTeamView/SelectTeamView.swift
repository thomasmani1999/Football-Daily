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
    @State var searchTex: String = ""
    @ObservedObject var viewModel: SelectTeamViewModel = SelectTeamViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(.clear)
                VStack {
                    
                    Text("Selected Country")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundStyle(.white)
                        .padding(.bottom, 20)
                        .animation(.easeIn, value: isCountrySelected)
                    
            
                    if viewModel.selectedCountry != nil {
                        
                        Group {
                            WebImage(url: URL(string: viewModel.selectedCountry?.flag ?? ""), context: [.imageThumbnailPixelSize: CGSize.zero])
                                .resizable()
                                .scaledToFill()
                                .shadow(color: .black, radius: 2)
                                .border(Color.black, width: 1)
                            
                            Text(viewModel.selectedCountry?.name ?? "")
                                .font(.system(size: isCountrySelected ? 15 : 30))
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                            
                            Spacer()
                        }
                        .frame(width: isCountrySelected ? 120 : 150, alignment: .center)
                        .animation(.easeInOut, value: isCountrySelected)
                        
                        
                        if isCountrySelected {
                            Text("Selected League")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundStyle(.white)
                                .padding(.bottom, 30)
                            
                            AsyncImage(url:  URL(string: viewModel.selectedLeague?.league?.logo ?? "")){ result in
                                result.image?
                                    .resizable()
                                    .scaledToFill()
                                
                            }
                            .frame(width: 200, alignment: .center)
                            
                            Text(viewModel.selectedLeague?.league?.name ?? "")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    
                    
                    Spacer()
                    
                    if isCountrySelected {
                        List {
                            Picker("League", selection: $viewModel.selectedLeague) {
                                ForEach(viewModel.leagues , id: \.id) { league in
                                    Text(league.league?.name ?? "")
                                            .font(.system(size: 30))
                                            .fontWeight(.bold)
                                            .fontDesign(.rounded)
                                            .foregroundStyle(.white)
                                            .tag(league as? LeagueInfo)
                                }
                            }
                        }
                        .scrollDisabled(true)
                        .scrollContentBackground(.hidden)
                        .background(.clear)
                        .frame(height: 110)
                        .padding(.bottom, 25)
                    } else {
                        List {
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
                        }
                        .scrollDisabled(true)
                        .scrollContentBackground(.hidden)
                        .background(.clear)
                        .frame(height: 110)
                        .padding(.bottom, 25)
                    }
                    
                    Button("Next") {
                        if viewModel.selectedCountry != nil {
                            Task {
                                isLoading = true
                                await viewModel.getLeagues()
                                isCountrySelected = true
                                isLoading = false
                            }
                        }
                    }
                    .disabled(!(viewModel.selectedCountry != nil))
                    .padding()
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    .background(Color.backgroundGrey)
                    .NeumorphicStyle()
                }
                .blur(radius: isLoading ? 5 : 0)
                
                if isLoading {
                    LoadingView()
                }
            }
            .searchable(text: $searchTex)
            .onChange(of: searchTex, { oldValue, newValue in
                print("\(oldValue) \(newValue)")
            })
            .background(Color.backgroundGrey)
            .onAppear(perform: {
                Task {
                    isLoading = true
                    await viewModel.getCountries()
                    isLoading = false
                }
        })
        }
    }
}

#Preview {
    SelectTeamView(isFavTeamSelected: .constant(false))
}
