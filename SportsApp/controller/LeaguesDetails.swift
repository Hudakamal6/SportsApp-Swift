//
//  LeaguesDetails.swift
//  SportsApp
//
//  Created by Huda kamal  on 02/05/2023.
//

import UIKit

class LeaguesDetails: UIViewController {

    var sportType : String = Constants.football
    var leagueKey : Int = 152
    var latestResultsArr: [latestResults] = []
    var upComingArr : [latestResults] = []
    var leagueTeamsArr : [LeagueTeams] = []

    var flag = false
    
    
    @IBOutlet weak var latestResultTable: UITableView!
    @IBOutlet weak var upComingCollection: UICollectionView!
    @IBOutlet weak var TeamsCollection: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

            activeViews()
        
        
       // System Date— Swift
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: currentDate)

       // After 7-Days
        var dateComponent = DateComponents()
        dateComponent.day = 7
        let afterDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)

      //  Before 7-Days
        dateComponent.day = -7
        let beforeDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        

//        print("current  \(currentDate)")
//        print("after \(afterDate)")
//        print("before \(beforeDate)")
 

        NetworkingManager.getLeagueTeams(endPoint: Constants.teams, sportType: sportType, leagueId : leagueKey) { error, teamsDetails, successKey in
                if error != nil {
                    print(error?.localizedDescription)
                }
                if let teamDetails = teamsDetails{
                    
                    self.leagueTeamsArr = teamDetails
                    self.flag = true
                    DispatchQueue.main.async {
                        self.TeamsCollection.reloadData()
                    }
                }
            }

        
        NetworkingManager.getLatestResults(endPoint: Constants.fixtures, sportType: sportType, leagueKey: leagueKey) { error, leagueDetails, successKey in
            if error != nil {
                print(error)
            }
            if let leagueDetailsArr = leagueDetails{
                
                self.latestResultsArr = leagueDetailsArr
                
                self.flag = true
                DispatchQueue.main.async {
                    self.latestResultTable.reloadData()
                }
                print("tennis playerr \(leagueDetails?[0].event_first_player)")
            }
        }
       
        
        NetworkingManager.getUpComing(endPoint: Constants.fixtures, sportType: sportType, leagueKey: leagueKey) { error, upComing, successKey in
            if error != nil{
                print(error?.localizedDescription)
            }
            if let upComingArr = upComing{
                self.upComingArr = upComingArr
                self.flag = true
                DispatchQueue.main.async {
                    self.upComingCollection.reloadData()
                }
            }
            
        }
  
    }

    func activeViews(){
        latestResultTable.delegate = self
        latestResultTable.dataSource = self
        upComingCollection.dataSource = self
        upComingCollection.delegate = self
        TeamsCollection.delegate = self
        TeamsCollection.dataSource = self
        
        latestResultTable.register(UINib(nibName: "LatestResultsCell", bundle: nil), forCellReuseIdentifier: "latestReult")
        
       TeamsCollection.register(UINib(nibName: "LeagueTeamsCell", bundle: nil), forCellWithReuseIdentifier: "TeamsCell")
        
        upComingCollection.register(UINib(nibName: "UpComingEventsCell", bundle: nil), forCellWithReuseIdentifier: "upComingCell")
    }

}


extension LeaguesDetails : UITableViewDelegate,UITableViewDataSource , UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestResultsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "latestReult", for: indexPath) as! LatestResultsCell
        
        cell.configureCell(latestResult: latestResultsArr, indexPath: indexPath,sportType: sportType)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(flag){
            if collectionView == TeamsCollection{
                if(sportType == Constants.tennis){
                    return latestResultsArr.count}
                else{
                    return leagueTeamsArr.count
                }
            }else
            {
                return upComingArr.count
            }
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if(flag){
            if collectionView == TeamsCollection{
                
                let leagueTeamsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCell", for: indexPath) as! LeagueTeamsCell
                
                if(sportType == Constants.tennis){
                   
                    leagueTeamsCell.configureTennisCell(tenniPlayers: latestResultsArr, indexPath: indexPath)
                }else{
                  
                    leagueTeamsCell.configureCell(leagueTeams: leagueTeamsArr, indexPath: indexPath, sportType: sportType)
                }
                return leagueTeamsCell
            }else{
                let upComingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComingCell", for: indexPath) as! UpComingEventsCell
            
                upComingCell.configureCell(upComingEvents: upComingArr, indexPath: indexPath,sportType: sportType)
             
                return upComingCell
            }
        }else{
            let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath) as! UICollectionViewCell
            return defaultCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == TeamsCollection{
            return CGSize(width: 100, height: 205)
        }else {
            return CGSize(width: 373, height: 200)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == TeamsCollection{
            let teamDetails = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetails") as? TeamDetails
            teamDetails?.teamKey = leagueTeamsArr[indexPath.row].teamKey
            teamDetails?.leagueKey = leagueKey
            teamDetails?.sportType = sportType
            navigationController?.pushViewController(teamDetails!, animated: true)
        }
    }
    func setBackground(){
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background1")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        let backgroundImageC = UIImage(named: "background1")
        let imageViewC = UIImageView(image: backgroundImageC)

    }
}
