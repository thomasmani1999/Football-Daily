//
//  countriesResponse.swift
//  Football Daily
//
//  Created by Thomas Mani on 25/07/24.
//

import Foundation

struct Country: Codable, Hashable {
    let id: UUID = UUID()
    let name : String?
    let code : String?
    let flag : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case code = "code"
        case flag = "flag"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        flag = try values.decodeIfPresent(String.self, forKey: .flag)
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
}

struct CountriesResponse: Codable {
    let results : Int?
    let response : [Country]?

    enum CodingKeys: String, CodingKey {

        case results = "results"
        case response = "response"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent(Int.self, forKey: .results)
        response = try values.decodeIfPresent([Country].self, forKey: .response)
    }

}
