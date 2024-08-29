//
//  SelectCountryLeagueView.swift
//  Football Daily
//
//  Created by Thomas Mani on 30/08/24.
//

import SwiftUI

struct SelectCountryLeagueView: View {
    
    @ObservedObject var viewModel: SelectTeamViewModel
    @Binding var presentSheet: Bool
    @State var isCountrySelected: Bool
    @State var isLoading = false
    
    var body: some View {
        NavigationView {
            if isCountrySelected {
                List(viewModel.filteredCountryList,id: \.self) { country in
                    NavigationLink {
                        ZStack(content: {
                            List(viewModel.filteredLeaguesList,id: \.self) { league in
                                HStack {
                                    if let url = URL(string: league.league?.logo ?? "") {
                                        AsyncImage(url: url) { result in
                                            result
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 25,height: 25)
                                            
                                        } placeholder: {
                                            ProgressView()
                                                .frame(width: 25,height: 25)
                                        }

                                    }
                                    Text(league.league?.name  ?? "")
                                        .font(.body)
                                }
                                .onTapGesture {
                                    viewModel.selectedLeague = league
                                    presentSheet = false
                                }
                            }
                            .searchable(text: $viewModel.leagueSearchTerm, prompt: "League")
                            .onAppear(perform: {
                                viewModel.selectedCountry = country
                                Task {
                                    isLoading = true
                                    await viewModel.getLeagues()
                                    isLoading = false
                                }
                            })
                            
                            if isLoading {
                                ProgressView()
                                    .frame(width: 200, height: 200, alignment: .center)
                            }
                        })
                    } label: {
                        HStack {
                            Text(country.code?.flag() ?? "")
                            Text(country.name ?? "")
                                .font(.body)
                        }
                    }
                }
                .listStyle(.sidebar)
                .searchable(text: $viewModel.countrySearchTerm, prompt: "Country")
            } else {
                ZStack(content: {
                    List(viewModel.filteredLeaguesList,id: \.self) { league in
                        HStack {
                            if let url = URL(string: league.league?.logo ?? "") {
                                AsyncImage(url: url) { result in
                                    result
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25,height: 25)
                                    
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 25,height: 25)
                                }

                            }
                            Text(league.league?.name  ?? "")
                                .font(.body)
                        }
                        .onTapGesture {
                            viewModel.selectedLeague = league
                            presentSheet = false
                        }
                    }
                    .searchable(text: $viewModel.leagueSearchTerm, prompt: "League")
                    .onAppear(perform: {
                        Task {
                            isLoading = true
                            await viewModel.getLeagues()
                            isLoading = false
                        }
                    })
                    
                    if isLoading {
                        ProgressView()
                            .frame(width: 200, height: 200, alignment: .center)
                    }
                })
            }
        }
        .presentationDetents([.medium, .large])
    }
}

#Preview {
    SelectCountryLeagueView(viewModel: SelectTeamViewModel(), presentSheet: .constant(true), isCountrySelected: true)
}
