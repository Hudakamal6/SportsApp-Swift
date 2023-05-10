//
//  leagueTeamss.swift
//  SportsApp
//
//  Created by Huda kamal  on 08/05/2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let leagueTeams = try? JSONDecoder().decode(LeagueTeams.self, from: jsonData)

import Foundation

// MARK: - LeagueTeams
struct LeagueTeamsResponse: Codable {
    let success: Int
    let result: [LeagueTeams]
}

// MARK: - Result
struct LeagueTeams: Codable {
    let teamKey: Int
    let teamName: String
    let teamLogo: String?


    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"

    }
}




