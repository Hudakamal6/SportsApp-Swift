//
//  FavView.swift
//  SportsApp
//
//  Created by Huda kamal  on 02/05/2023.
//

import UIKit
import CoreData

class FavView: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var teamsArr = [Team]()
    var context: NSManagedObjectContext!
    var coreDB = CoreDataManager.dataBase
    var isDataReturned = false
    
    
    @IBOutlet weak var test: UILabel!
    
    @IBOutlet weak var favTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        favTable.delegate = self
        favTable.dataSource = self
        
        setBackground()
     
        
        
    }
    override func viewWillAppear(_ animated: Bool) {

        if(coreDB.checkIfDBIsEmpty(context: context)){
            DispatchQueue.main.async {
                self.test.text = "THERE iS NO FAV "
                self.favTable.isHidden = true
            }
            
        }else{
          var teamsFromDB =  coreDB.getTeamsFromDB(context: context)
            teamsArr = teamsFromDB
            isDataReturned = true
            DispatchQueue.main.async {
                self.test.text = "FAV DATA FROM CORE DATA"
                self.favTable.isHidden = false
                self.favTable.reloadData()
            }
            print(teamsArr[0].teamName)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favTeamCell", for: indexPath)
    
        cell.textLabel?.text = teamsArr[indexPath.row].teamName
        let backgroundImageC = UIImage(named: "background1")
        let imageViewC = UIImageView(image: backgroundImageC)
        cell.backgroundView = imageViewC
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        var team = teamsArr[indexPath.row]
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                
                self.coreDB.deleteTeamFromDB(context: self.context, team: team)
                self.teamsArr.remove(at: indexPath.row)
                if(self.teamsArr.count == 0){
                    self.favTable.isHidden = true
                    self.test.text = "THERE iS NO FAV Teams"
                }else{
                    self.favTable.reloadData()
                }
            }))
            self.present(alert, animated: true)
                self.favTable.reloadData()
            
        }
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return" Favorite Teams"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teamDetails = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetails") as? TeamDetails
        teamDetails?.teamKey = teamsArr[indexPath.row].teamId
        navigationController?.pushViewController(teamDetails!, animated: true)
    }
    func setBackground(){
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background1")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        let backgroundImageC = UIImage(named: "background1")
        let imageViewC = UIImageView(image: backgroundImageC)
        self.favTable.backgroundView = imageViewC
    }
}
