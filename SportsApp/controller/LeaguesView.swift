//
//  LeaguesView.swift
//  SportsApp
//
//  Created by Huda kamal  on 02/05/2023.
//

import UIKit

class LeaguesView: UITableViewController {
    @IBOutlet var leagueTable: UITableView!
    
    var allLeagueArr: [League] = []
    var flag = false
    
    var endPoint :String = ""
    var sportType:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
        NetworkingManager.getAllLeagues(endPoint: endPoint, sportType: sportType) { error, allLeagues,success  in
            if error != nil {
                print(error?.localizedDescription)
            }
            if let leagueArr = allLeagues{
                self.allLeagueArr = leagueArr
                self.flag = true
                DispatchQueue.main.async {
                    self.leagueTable.reloadData()
                }
            }
        }

        leagueTable.register(UINib(nibName: "LeaguesCell", bundle: nil), forCellReuseIdentifier: "leaguesCell")
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        title = "Sports"
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(flag) {
            return allLeagueArr.count
        }
        else{
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaguesCell", for: indexPath) as! LeaguesCell
    
        let backgroundImageC = UIImage(named: "background1")
        let imageViewC = UIImageView(image: backgroundImageC)
        cell.backgroundColor = UIColor.red
        if(flag){
            cell.configureCell(allLeagues: self.allLeagueArr, indexPath: indexPath,sportType: sportType)
           
        }
           
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetailsView = self.storyboard?.instantiateViewController(withIdentifier: "leagueDetailsView") as? LeaguesDetails
        leagueDetailsView?.leagueKey = allLeagueArr[indexPath.row].league_key
        leagueDetailsView?.sportType = sportType
        navigationController?.pushViewController(leagueDetailsView!, animated: true)
    }
    func setBackground(){
    
        let backgroundImageC = UIImage(named: "background1")
        let imageViewC = UIImageView(image: backgroundImageC)
        self.leagueTable.backgroundView = imageViewC
    }

}
