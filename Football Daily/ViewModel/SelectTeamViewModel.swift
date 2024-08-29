//
//  SelectTeamViewModel.swift
//  Football Daily
//
//  Created by Thomas Mani on 31/07/24.
//

import Foundation

@MainActor class SelectTeamViewModel: ObservableObject {
    
    @Published var selectedCountry: Country?
    @Published var selectedLeague: LeagueInfo?
    @Published var countriesList: [Country] = []
    @Published var leagues: [LeagueInfo] = []
    @Published var countrySearchTerm: String = ""
    @Published var leagueSearchTerm: String = ""
    
    var filteredCountryList: [Country] {
        if countrySearchTerm.isEmpty {
            return countriesList
        } else {
            return countriesList.filter {  $0.name?.contains(countrySearchTerm) ?? false }
        }
    }
    
    var filteredLeaguesList: [LeagueInfo] {
        if leagueSearchTerm.isEmpty {
            return leagues
        } else {
            return leagues.filter {  $0.league?.name?.contains(leagueSearchTerm) ?? false }
        }
    }
    
    func getCountries() async {
        let countries = LocalDataManager.shared.readCountriesData()
        if !countries.isEmpty {
            countriesList = countries.sorted(by: { $0.name ?? "" < $1.name ?? ""})
        } else {
            await APIManager().sendRequest(endpoint: Endpoints.countries.rawValue) { [weak self] (result: Result<CountriesResponse, Error>) in
                switch result {
                case .success(let data):
                    self?.countriesList = data.response?.sorted(by: { $0.name ?? "" < $1.name ?? ""}) ?? []
                    LocalDataManager.shared.writeCountriesData(countries: self?.countriesList ?? [])
                case .failure(let error):
                    print("Failed with error: \(error)")
                }
            }
        }
    }
    
    func getLeagues() async {
        var inputReq = LeagueInputRequest()
        inputReq.code = selectedCountry?.code
        inputReq.country = selectedCountry?.name
        await APIManager().sendRequest(endpoint: Endpoints.leagues.rawValue, parameters: inputReq) { [weak self] (result: Result<LeagueResponse, Error>) in
            switch result {
            case .success(let data):
                self?.leagues = data.response ?? []
            case .failure(let error):
                print("Failed with error: \(error)")
            }
        }
    }
}

extension SelectTeamViewModel: SearchBarDelegate {
    func searchFor(text: String) {
        
    }
}
