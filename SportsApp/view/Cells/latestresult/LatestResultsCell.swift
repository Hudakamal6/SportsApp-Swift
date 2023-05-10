//
//  LatestResultsCell.swift
//  SportsApp
//
//  Created by Huda kamal  on 06/05/2023.
//

import UIKit
import Kingfisher

class LatestResultsCell: UITableViewCell {
    @IBOutlet weak var event_Stop_Date: UILabel!
    
    @IBOutlet weak var team_1_image: UIImageView!

    @IBOutlet weak var team_2_image: UIImageView!
    
    @IBOutlet weak var team_1_name: UILabel!
    @IBOutlet weak var team_2_name: UILabel!
    
    @IBOutlet weak var finalResult: UILabel!

    @IBOutlet weak var event_time: UILabel!
    @IBOutlet weak var event_date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    func configureCell(latestResult : [latestResults], indexPath : IndexPath,sportType : String){
        team_1_name.text = latestResult[indexPath.row].event_home_team
        team_2_name.text = latestResult[indexPath.row].event_away_team
        
        finalResult.text = latestResult[indexPath.row].event_final_result
        
        event_time.text = latestResult[indexPath.row].event_time
        event_date.text = latestResult[indexPath.row].event_date
        
        switch(sportType){
        case Constants.football:
            team_1_image.kf.indicatorType = .activity
            self.team_1_image.kf.setImage(with: URL(string: latestResult[indexPath.row].home_team_logo ?? ""),placeholder: UIImage(named: "footballTeam") )
            team_2_image.kf.indicatorType = .activity
            self.team_2_image.kf.setImage(with: URL(string: latestResult[indexPath.row].away_team_logo ?? ""))
            break
        case Constants.basketball:
            team_1_image.kf.indicatorType = .activity
            self.team_1_image.kf.setImage(with: URL(string: latestResult[indexPath.row].event_home_team_logo ?? ""),placeholder: UIImage(named: "basketballTeam"))
            team_2_image.kf.indicatorType = .activity
            self.team_2_image.kf.setImage(with: URL(string: latestResult[indexPath.row].event_away_team_logo ?? ""),placeholder: UIImage(named: "basketballTeam"))
            break
        case Constants.cricketball:
            event_date.text  = latestResult[indexPath.row].event_date_start
            event_Stop_Date.text = latestResult[indexPath.row].event_date_stop
            team_1_image.kf.indicatorType = .activity
            self.team_1_image.kf.setImage(with: URL(string: latestResult[indexPath.row].event_home_team_logo ?? ""),placeholder: UIImage(named: "cricketballTeam"))
            team_2_image.kf.indicatorType = .activity
            self.team_2_image.kf.setImage(with: URL(string: latestResult[indexPath.row].event_away_team_logo ?? ""),placeholder: UIImage(named: "cricketballTeam"))
            break
            
        case Constants.tennis:
            team_1_name.text = latestResult[indexPath.row].event_first_player
            team_2_name.text = latestResult[indexPath.row].event_second_player
            event_date.text  = latestResult[indexPath.row].event_date_start
            team_1_image.kf.indicatorType = .activity
            self.team_1_image.kf.setImage(with: URL(string: latestResult[indexPath.row].event_first_player_logo ?? ""),placeholder: UIImage(named: "cricketballTeam"))
            team_2_image.kf.indicatorType = .activity
            self.team_2_image.kf.setImage(with: URL(string: latestResult[indexPath.row].event_second_player_logo ?? ""),placeholder: UIImage(named: "cricketballTeam"))
            break
            
        default: break
            
        }
    }
}
