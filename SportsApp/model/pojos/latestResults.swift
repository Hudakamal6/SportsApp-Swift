//
//  LeagueDetails.swift
//  SportsApp
//
//  Created by Huda kamal  on 06/05/2023.
//

import Foundation

// MARK: - LeagueDetails
struct latestResultsResponse : Codable {
    let success: Int
    let result: [latestResults]
}

// MARK: - Result
struct latestResults: Codable {
    
    let event_date : String?
    let event_time :String?
    let event_home_team :String?
    let event_away_team : String?
    let event_final_result : String?
    let home_team_logo : String?
    let away_team_logo : String?
    
    let event_home_team_logo: String?
    let event_away_team_logo: String?
    
    // for cricket ball
    let event_date_start : String?
    let event_date_stop :String?
    
    let event_home_final_result : String?
    let event_away_final_result : String?
    

    // for tennis
    let event_first_player : String?
    let event_second_player:String?
    
    let event_first_player_logo : String?
    let event_second_player_logo :String?
    
    
    
}
    
