//
//  LeaguesCell.swift
//  SportsApp
//
//  Created by Huda kamal  on 04/05/2023.
//

import UIKit
import Kingfisher
class LeaguesCell: UITableViewCell {
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var leagueName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(allLeagues:[League],indexPath:IndexPath,sportType : String) {
        
        self.leagueName.text = allLeagues[indexPath.row].league_name
        self.countryName.text = allLeagues[indexPath.row].country_name
        
        self.leagueImage.kf.indicatorType = .activity
        
        
        switch(sportType){
        case Constants.football:
            self.leagueImage.kf.setImage(with: URL(string: allLeagues[indexPath.row].league_Logo ?? ""),placeholder: UIImage(named: "footballLeague"))
            break
        case Constants.basketball:
            self.leagueImage.kf.setImage(with: URL(string: allLeagues[indexPath.row].league_Logo ?? ""),placeholder: UIImage(named: "basketLeague"))
            break
        case Constants.cricketball:
            self.leagueImage.kf.setImage(with: URL(string: allLeagues[indexPath.row].league_Logo ?? ""),placeholder: UIImage(named: "cricketLeague"))
            break
            
        default:
            break
        }
        
    }
}

