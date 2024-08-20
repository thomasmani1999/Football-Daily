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
    @State var isFilterBoxExpanded: Bool = false
    @StateObject var viewModel: SelectTeamViewModel = SelectTeamViewModel()
    @State var filterOptions: [String] = []
    @State var isAnimating = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(.clear)
                VStack {
                    SearchBarView(model: viewModel, placeholder: "Teams")
                    
                    HStack {
                        Text("Teams")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundStyle(.white)
                            .padding(.leading, 20)
                            .animation(.easeIn, value: isCountrySelected)
                        
                        Spacer()
                        Button(action: {
                            filterOptions = ["Country"]
                            if isCountrySelected {
                                filterOptions.append("League")
                            }
                            withAnimation {
                                isFilterBoxExpanded.toggle()
                            }
                        }, label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                                .padding(.trailing, 20)
                                .foregroundStyle(.white)
                        })
                        .overlay(alignment: .top, content: {
                            if isFilterBoxExpanded {
                                VStack(alignment: .trailing,content: {
                                    ForEach(filterOptions, id: \.self) { value in
                                        Rectangle()
                                            .fill(.black)
                                            .presentationCornerRadius(2)
                                            .frame(height: 3)
                                        Button(action: {
                                            
                                        }, label: {
                                            Text(value)
                                                .foregroundStyle(.black)
                                                .font(.system(size: 10))
                                                .fontWeight(.semibold)
                                                .fontDesign(.rounded)
                                                .padding(2)
                                        })
                                    }
                                    Rectangle()
                                        .fill(.black)
                                        .frame(height: 3)
                                })
                                .transition(.opacity)
                                .padding(5)
                                .frame(width: 60)
                                .background(Color.white)
                                .offset(x: -30, y: 30)
                            } else if !isCountrySelected {
                                Image(systemName: "arrow.up")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30)
                                    .offset(x: -9.5)
                                    .foregroundStyle(.white)
                                    .bold()
                                    .offset(y: isAnimating ? 40 : 30)
                                    .symbolEffect(.pulse, options: .repeating.speed(2), value: isAnimating)
                                    .onAppear() {
                                        isAnimating.toggle()
                                    }
                            }
                        })
                    }
                    
                    Spacer()
                    
                    ZStack {
                        if !isCountrySelected {
                            Text("First Select a Country from the filter \n \n Then select a League from the Country")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundStyle(.white)
                                .padding(.leading, 20)
                                .animation(.easeIn, value: isCountrySelected)
                        }
                    }
                    
                    Spacer()
                    
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
                    .presentationCornerRadius(20)
                    .background(Color.backgroundGrey)
                    .NeumorphicStyle()
                }
                .blur(radius: isLoading ? 5 : 0)
                
                if isLoading {
                    LoadingView()
                }
            }
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
