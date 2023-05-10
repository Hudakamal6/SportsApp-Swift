//
//  TeamDetailsCell.swift
//  SportsApp
//
//  Created by Huda kamal  on 08/05/2023.
//

import UIKit
import Kingfisher

class TeamDetailsCell: UITableViewCell {
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var playerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(players :[Player] ,indexPath:IndexPath) {
        
        
        self.playerName.text = players[indexPath.row].playerName
        self.playerImage.kf.indicatorType = .activity
        
        var image = players[indexPath.row].playerImage
        var url = URL(string: image)
        
        if(image != nil){
            self.playerImage.kf.setImage(with: url)
        }else{
           var urll = URL(string:"https://apiv2.allsportsapi.com/logo/logo_leagues/152_premier-league.png")
            self.playerImage.kf.setImage(with: urll)
        }
    
    }
    
}
