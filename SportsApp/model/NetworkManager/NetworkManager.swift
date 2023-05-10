//
//  NetworkManager.swift
//  SportsApp
//
//  Created by Huda kamal  on 04/05/2023.
//

import Foundation
import CoreData
struct NetworkingManager {
    
    
    static func getLeaguesUrl(endPoint :String , sportType : String)-> String{
        
        let url = "https://apiv2.allsportsapi.com/\(sportType)/?met=\(endPoint)&APIkey=\(Constants.ApiKey)"
        
        return url
    }
    
    
    static func getUpComing(endPoint :String , sportType : String , leagueKey: Int )-> String{
        let url = "https://apiv2.allsportsapi.com/\(sportType)/?met=\(endPoint)&APIkey=\(Constants.ApiKey)&from=2018-05-23&to=2023-05-23&leagueId=\(leagueKey)"
        
        return url
        
    }
    static func getLatestResults(endPoint :String , sportType : String , leagueKey: Int )-> String{
        let url = "https://apiv2.allsportsapi.com/\(sportType)/?met=\(endPoint)&APIkey=\(Constants.ApiKey)&from=2018-05-23&to=2023-05-23&leagueId=\(leagueKey)"
        
        return url
    }
    

    
    static func getLeagueTeamsUrl(endPoint :String ,sportType : String, leagueKey: Int )-> String{
        let url = "https://apiv2.allsportsapi.com//\(sportType)/?met=\(endPoint)&leagueId=\(leagueKey)&APIkey=\(Constants.ApiKey)"
    

        return url
    }

    
    static func getTeamDetailsUrl(endPoint :String ,sportType : String, teamKey: Int ,leagueKey:Int)-> String{
        let url = "https://apiv2.allsportsapi.com/\(sportType)/?&met=\(endPoint)&teamId=\(teamKey)&APIkey=\(Constants.ApiKey)&leagueId=\(leagueKey)"
        

    
        
        return url
    }
    
    
    static func getAllLeagues (endPoint : String ,sportType :String , completion: @escaping(_ error: Error?, _ allLeagues: [League]? , _ successKey : Int?) -> Void) {
        if let url = URL(string: getLeaguesUrl(endPoint: endPoint, sportType: sportType)) {
            var request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            let task =  session.dataTask   (with: request){
                (data, response, error) in
                do{
                    let response = try JSONDecoder().decode(LeaguesResponse.self, from: data!)
                    completion(nil,response.result,response.success)
                } catch let error {
                    print(error.localizedDescription)
                    completion(error,nil,nil)
                }
            }
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
    
    
    static   func getLatestResults (endPoint : String ,sportType :String , leagueKey:Int  , completion: @escaping(_ error: Error?, _ leagueDetails: [latestResults]? , _ successKey : Int?) -> Void) {
       
        if let url = URL(string: getLatestResults(endPoint: endPoint, sportType: sportType, leagueKey: leagueKey))
        {
            var request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            let task =  session.dataTask   (with: request){
                (data, response, error) in
                do{
                    let response = try JSONDecoder().decode(latestResultsResponse.self, from: data!)
                    completion(nil,response.result,response.success)
                } catch let error {
                    print("errrorrrrrrrrrrrrr \(error)")
                
                    completion(error,nil,nil)
                }
            }
            task.resume()
        }
    }
    
    static   func getUpComing(endPoint : String ,sportType :String , leagueKey:Int , completion: @escaping(_ error: Error?, _ upComing: [latestResults]? , _ successKey : Int?) -> Void) {
       
        if let url = URL(string: getUpComing(endPoint: endPoint, sportType: sportType, leagueKey: leagueKey))
        {
            var request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            let task =  session.dataTask   (with: request){
                (data, response, error) in
                do{
                    let response = try JSONDecoder().decode(latestResultsResponse.self, from: data!)
                    completion(nil,response.result,response.success)
                } catch let error {
                    print("errrorrrrrrrrrrrrr \(error)")
                
                    completion(error,nil,nil)
                }
            }
            task.resume()
        }
    }
    static   func getLeagueTeams (endPoint : String ,sportType :String , leagueId : Int , completion: @escaping(_ error: Error?, _ teamsDetails: [LeagueTeams]? , _ successKey : Int?) -> Void) {
       
        if let url = URL(string: getLeagueTeamsUrl(endPoint: endPoint, sportType: sportType, leagueKey: leagueId))
        
        {
            var request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            let task =  session.dataTask(with: request){
                (data, response, error) in
                do{
                    if let safeData = data{
                        let response = try JSONDecoder().decode(LeagueTeamsResponse.self, from: safeData)
                        completion(nil,response.result,response.success)
                       // print(response.result[0].teamKey)
                        
                    }
                }catch let error {
                    print(" errooorrrrrrrrrrrr \(error)")
                    completion(error,nil,nil)
                }
            }
            task.resume()
        }
    }
    
    static   func getTeamDetails (endPoint : String ,sportType :String , teamKey : Int ,leagueKey:Int, completion: @escaping(_ error: Error?, _ teamsDetails: [Teams]? , _ successKey : Int?) -> Void) {
       
        if let url = URL(string: getTeamDetailsUrl(endPoint: endPoint, sportType: sportType, teamKey: teamKey,leagueKey: leagueKey))
        
        {
            var request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            let task =  session.dataTask   (with: request){
                (data, response, error) in
                do{
                    let response = try JSONDecoder().decode(TeamDetailssResponse.self, from: data!)
                    completion(nil,response.result,response.success)
                   // print(response.success)
                } catch let error {
                    print(error.localizedDescription)
                    completion(error,nil,nil)
                }
            }
            task.resume()
        }
    }
}



