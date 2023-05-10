//
//  allLeagues.swift
//  SportsApp
//
//  Created by Huda kamal  on 04/05/2023.
//
import Foundation

// MARK: - AllLeague
struct LeaguesResponse: Decodable {
    let success: Int
    let result: [League]
}

// MARK: - Result
struct League: Decodable {
    let league_key: Int
    let league_name: String
    let country_key: Int?
    let country_name: String?
    let  league_Logo, countryLogo: String?
    
    
}

