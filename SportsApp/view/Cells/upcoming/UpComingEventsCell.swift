//
//  UpComingEventsCell.swift
//  SportsApp
//
//  Created by Huda kamal  on 06/05/2023.
//

import UIKit
import Kingfisher

class UpComingEventsCell: UICollectionViewCell {
    @IBOutlet weak var event_date_stop: UILabel!
    
    @IBOutlet weak var team_1_image: UIImageView!
    
    @IBOutlet weak var team_1_name: UILabel!
    
    @IBOutlet weak var team_2_image: UIImageView!
    
    @IBOutlet weak var team_2_name: UILabel!
    
    @IBOutlet weak var event_time: UILabel!
    
    @IBOutlet weak var event_date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(upComingEvents: [latestResults], indexPath:IndexPath, sportType : String){
        
        team_1_name.text = upComingEvents[indexPath.row].event_home_team
        team_2_name.text = upComingEvents[indexPath.row].event_away_team
        
        event_time.text = upComingEvents[indexPath.row].event_time
        event_date.text = upComingEvents[indexPath.row].event_date
        
        switch(sportType){
        case Constants.football:
            team_1_image.kf.indicatorType = .activity
            self.team_1_image.kf.setImage(with: URL(string: upComingEvents[indexPath.row].home_team_logo ?? ""),placeholder: UIImage(named: "footballTeam") )
            team_2_image.kf.indicatorType = .activity
            self.team_2_image.kf.setImage(with: URL(string: upComingEvents[indexPath.row].away_team_logo ?? ""))
            break
        case Constants.basketball:
            team_1_image.kf.indicatorType = .activity
            self.team_1_image.kf.setImage(with: URL(string: upComingEvents[indexPath.row].event_home_team_logo ?? ""),placeholder: UIImage(named: "basketballTeam"))
            team_2_image.kf.indicatorType = .activity
            self.team_2_image.kf.setImage(with: URL(string: upComingEvents[indexPath.row].event_away_team_logo ?? ""),placeholder: UIImage(named: "basketballTeam"))
            break
        case Constants.cricketball:
            event_date.text  = upComingEvents[indexPath.row].event_date_start
            event_date_stop.text = upComingEvents[indexPath.row].event_date_stop
            team_1_image.kf.indicatorType = .activity
            self.team_1_image.kf.setImage(with: URL(string: upComingEvents[indexPath.row].event_home_team_logo ?? ""),placeholder: UIImage(named: "cricketballTeam"))
            team_2_image.kf.indicatorType = .activity
            self.team_2_image.kf.setImage(with: URL(string: upComingEvents[indexPath.row].event_away_team_logo ?? ""),placeholder: UIImage(named: "cricketballTeam"))
            break
        case Constants.tennis:
            team_1_name.text = upComingEvents[indexPath.row].event_first_player
            team_2_name.text = upComingEvents[indexPath.row].event_second_player
            event_date.text  = upComingEvents[indexPath.row].event_date_start
            team_1_image.kf.indicatorType = .activity
            self.team_1_image.kf.setImage(with: URL(string: upComingEvents[indexPath.row].event_first_player_logo ?? ""),placeholder: UIImage(named: "cricketballTeam"))
            team_2_image.kf.indicatorType = .activity
            self.team_2_image.kf.setImage(with: URL(string: upComingEvents[indexPath.row].event_second_player_logo ?? ""),placeholder: UIImage(named: "cricketballTeam"))
            break
            
        default: break
            
        }
    }
}
   
