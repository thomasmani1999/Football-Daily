//
//  SelectTeamViewModel.swift
//  Football Daily
//
//  Created by Thomas Mani on 31/07/24.
//

import Foundation

class SelectTeamViewModel: ObservableObject {
    
    @Published var selectedCountry: Country?
    @Published var countriesList: [Country] = []
    
    func getCountries() async{
        await APIManager().sendRequest(endpoint: Endpoints.countries.rawValue) { [weak self] (result: Result<CountriesResponse, Error>) in
            switch result {
            case .success(let data):
                self?.countriesList = data.response?.sorted(by: { $0.name ?? "" < $1.name ?? ""}) ?? []
                self?.selectedCountry = self?.countriesList.first
            case .failure(let error):
                print("Failed with error: \(error)")
            }
        }
    }
}
