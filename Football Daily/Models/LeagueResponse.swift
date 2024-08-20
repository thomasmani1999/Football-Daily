//
//  LeagueResponse.swift
//  Football Daily
//
//  Created by Thomas Mani on 07/08/24.
//

import Foundation

struct LeagueInputRequest: Codable {
    var id: Int?
    var name: String?
    var country: String?
    var code: String?
    var season: Int?
    var team: Int?
    var type: String?
    var current: Bool?
    var search: String?
    var last: Int?
}

struct LeagueResponse: Codable {
    let results : Int?
    let response : [LeagueInfo]?

    enum CodingKeys: String, CodingKey {

        case results = "results"
        case response = "response"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent(Int.self, forKey: .results)
        response = try values.decodeIfPresent([LeagueInfo].self, forKey: .response)
    }

}

struct LeagueInfo : Codable, Hashable {
    var id = UUID()
    let league : League?
    let country : Country?
    let seasons : [Seasons]?

    enum CodingKeys: String, CodingKey {

        case league = "league"
        case country = "country"
        case seasons = "seasons"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        league = try values.decodeIfPresent(League.self, forKey: .league)
        country = try values.decodeIfPresent(Country.self, forKey: .country)
        seasons = try values.decodeIfPresent([Seasons].self, forKey: .seasons)
    }

    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    
    static func == (lhs: LeagueInfo, rhs: LeagueInfo) -> Bool {
        lhs.id == rhs.id
    }
}

struct League : Codable {
    let id : Int?
    let name : String?
    let type : String?
    let logo : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case type = "type"
        case logo = "logo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        logo = try values.decodeIfPresent(String.self, forKey: .logo)
    }

}

struct Seasons : Codable {
    let year : Int?
    let start : String?
    let end : String?
    let current : Bool?
    let coverage : Coverage?

    enum CodingKeys: String, CodingKey {

        case year = "year"
        case start = "start"
        case end = "end"
        case current = "current"
        case coverage = "coverage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        year = try values.decodeIfPresent(Int.self, forKey: .year)
        start = try values.decodeIfPresent(String.self, forKey: .start)
        end = try values.decodeIfPresent(String.self, forKey: .end)
        current = try values.decodeIfPresent(Bool.self, forKey: .current)
        coverage = try values.decodeIfPresent(Coverage.self, forKey: .coverage)
    }

}

struct Coverage : Codable {
    let fixtures : Fixtures?
    let standings : Bool?
    let players : Bool?
    let top_scorers : Bool?
    let top_assists : Bool?
    let top_cards : Bool?
    let injuries : Bool?
    let predictions : Bool?
    let odds : Bool?

    enum CodingKeys: String, CodingKey {

        case fixtures = "fixtures"
        case standings = "standings"
        case players = "players"
        case top_scorers = "top_scorers"
        case top_assists = "top_assists"
        case top_cards = "top_cards"
        case injuries = "injuries"
        case predictions = "predictions"
        case odds = "odds"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fixtures = try values.decodeIfPresent(Fixtures.self, forKey: .fixtures)
        standings = try values.decodeIfPresent(Bool.self, forKey: .standings)
        players = try values.decodeIfPresent(Bool.self, forKey: .players)
        top_scorers = try values.decodeIfPresent(Bool.self, forKey: .top_scorers)
        top_assists = try values.decodeIfPresent(Bool.self, forKey: .top_assists)
        top_cards = try values.decodeIfPresent(Bool.self, forKey: .top_cards)
        injuries = try values.decodeIfPresent(Bool.self, forKey: .injuries)
        predictions = try values.decodeIfPresent(Bool.self, forKey: .predictions)
        odds = try values.decodeIfPresent(Bool.self, forKey: .odds)
    }

}

struct Fixtures : Codable {
    let events : Bool?
    let lineups : Bool?
    let statistics_fixtures : Bool?
    let statistics_players : Bool?

    enum CodingKeys: String, CodingKey {

        case events = "events"
        case lineups = "lineups"
        case statistics_fixtures = "statistics_fixtures"
        case statistics_players = "statistics_players"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        events = try values.decodeIfPresent(Bool.self, forKey: .events)
        lineups = try values.decodeIfPresent(Bool.self, forKey: .lineups)
        statistics_fixtures = try values.decodeIfPresent(Bool.self, forKey: .statistics_fixtures)
        statistics_players = try values.decodeIfPresent(Bool.self, forKey: .statistics_players)
    }

}
