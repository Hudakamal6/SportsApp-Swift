//
//  TeamDetails.swift
//  SportsApp
//
//  Created by Huda kamal  on 02/05/2023.
//

import UIKit
import Kingfisher
import CoreData

class TeamDetails: UIViewController ,UITableViewDelegate,UITableViewDataSource, InsertedTeam  {
    func insertTeam() {
        
    }
    
    
    
//    var team : Teams?
    var teamsArr : [Teams] = []
    var flag = false
    var teamKey:Int = 0
    var leagueKey:Int = 0
    
    var sportType = ""
    var endPont = Constants.teams
    
    
    // for CoreDataBase
    
    var context: NSManagedObjectContext!
    var coreDB = CoreDataManager.dataBase
    
    var playersDefault = [Player]()
    @IBOutlet weak var teamImage: UIImageView!
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var teamTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        regiesterCell()
        setBackground()
        checkSportType()
        NetworkingManager.getTeamDetails(endPoint: endPont, sportType: sportType, teamKey: teamKey,leagueKey: leagueKey) { error, teamsDetails, successKey in
            if error != nil {
                print(error?.localizedDescription)
            }
            if let teamDetails = teamsDetails{
                
                self.teamsArr = teamDetails
                
                self.flag = true
                DispatchQueue.main.async {
                    self.teamTable.reloadData()
                    self.teamName.text = self.teamsArr[0].teamName
                    var teamImage = URL(string:self.teamsArr[0].teamLogo)
                    self.teamImage.kf.setImage(with: teamImage)

                }
            }

        }
        
        // CORE DB
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    
//        let check = coreDB.getTeamsFromDB(context: context)
//        print(check)
    }
    
    func regiesterCell(){
        
        teamTable.register(UINib(nibName: "TeamDetailsCell", bundle: nil), forCellReuseIdentifier: "TeamDetailsCell")
        
        teamTable.dataSource = self
        teamTable.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        title = "Team Details"
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(flag) {
            return teamsArr[0].players?.count ?? 0
        }
        else{
            return 2
        }
        
    }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamDetailsCell", for: indexPath) as! TeamDetailsCell
            if(flag){
                cell.configureCell(players:teamsArr[0].players ?? playersDefault,  indexPath: indexPath)}
            
            let backgroundImageC = UIImage(named: "background1")
            let imageViewC = UIImageView(image: backgroundImageC)
            cell.backgroundView = imageViewC
                return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 130
        }
        
    @IBAction func FavBtn(_ sender: Any) {
        let team = Team(teamId: teamKey, teamName: teamName.text ?? "defaultName")
        coreDB.insertDelegate = self
        coreDB.SaveTeamToDB(context: context, team: team)
        print("Team Inserted Successfully")
     
    }
    
    func setBackground(){
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background1")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        let backgroundImageC = UIImage(named: "background1")
        let imageViewC = UIImageView(image: backgroundImageC)
        self.teamTable.backgroundView = imageViewC
    }
    
    func checkSportType(){
        switch(sportType){
        case Constants.football:
            teamTable.isHidden = false
            break
        case Constants.basketball:
            teamTable.isHidden = true
            break
        case Constants.cricketball:
            teamTable.isHidden = true
            break
        default:
            break
        }
        
    }
   
}

