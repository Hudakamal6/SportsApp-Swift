//
//  LeagueTeamsCell.swift
//  SportsApp
//
//  Created by Huda kamal  on 06/05/2023.
//

import UIKit
import Kingfisher

class LeagueTeamsCell: UICollectionViewCell {
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var teamImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configureCell(leagueTeams:[LeagueTeams],indexPath:IndexPath , sportType : String) {
        teamName.text = leagueTeams[indexPath.row].teamName
        
        teamImage.kf.indicatorType = .activity
        
        switch(sportType){
        case Constants.football:
            self.teamImage.kf.setImage(with: URL(string: leagueTeams[indexPath.row].teamLogo ?? ""),placeholder: UIImage(named: "footballLeague"))
            break
            
        case Constants.basketball:
            self.teamImage.kf.setImage(with: URL(string: leagueTeams[indexPath.row].teamLogo ?? ""),placeholder: UIImage(named: "basketballTeam"))
            break
        case Constants.cricketball:
            self.teamImage.kf.setImage(with: URL(string: leagueTeams[indexPath.row].teamLogo ?? ""),placeholder: UIImage(named: "cricketballTeam"))
            break
//        case Constants.tennis:
//            self.teamImage.kf.setImage(with: URL(string: leagueTeams[indexPath.row].teamLogo ?? ""),placeholder: UIImage(named: "cricketballTeam"))
//            break
        default:
            break
        }
    }
    
    func configureTennisCell(tenniPlayers:[latestResults],indexPath:IndexPath){
        
        teamName.text = tenniPlayers[indexPath.row].event_first_player
        self.teamImage.kf.setImage(with: URL(string: tenniPlayers[indexPath.row].event_first_player_logo ?? ""),placeholder: UIImage(named: "cricketballTeam"))
        
    }
}
