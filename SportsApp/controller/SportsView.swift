//
//  SportssView.swift
//  SportsApp
//
//  Created by Huda kamal  on 05/05/2023.
//

import UIKit

class SportsView: UIViewController ,UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! SportsCell
        
          if indexPath.row == 0 {
             cell.sportImage.image = UIImage(named: "football")
          
          } else if indexPath.row == 1 {
              cell.sportImage.image = UIImage(named: "basketball3")
              
          } else if indexPath.row == 2 {
             cell.sportImage.image = UIImage(named: "tennis2")
          
          } else{
              cell.sportImage.image = UIImage(named: "cricketBall")
         
          }

        cell.sportImage = cell.sportImage.circleView as? UIImageView
        
          return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           

           let leaguesView = self.storyboard?.instantiateViewController(withIdentifier: "leaguesView") as? LeaguesView
   
           if indexPath.row == 0 {
               leaguesView?.endPoint = Constants.leagues
               leaguesView?.sportType=Constants.football
           }else if indexPath.row == 1{
               leaguesView?.endPoint = Constants.leagues
               leaguesView?.sportType=Constants.basketball
           }else if indexPath.row == 2{
               leaguesView?.endPoint = Constants.leagues
               leaguesView?.sportType=Constants.tennis
           }else {
               leaguesView?.endPoint = Constants.leagues
               leaguesView?.sportType=Constants.cricketball
           }
           navigationController?.pushViewController(leaguesView!, animated: true)
           
       }
    

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackground()
        NetworkingManager.getAllLeagues(endPoint: Constants.leagues, sportType: Constants.cricketball) { error, allLeagues,success  in
            if error != nil {
                print(error?.localizedDescription)
            }
            if let leagueArr = allLeagues{
               // print(leagueArr[0].league_name)
            }
           // print(success)
            
        }
    }
    

    func setBackground(){
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background1")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        let backgroundImageC = UIImage(named: "background1")
        let imageViewC = UIImageView(image: backgroundImageC)
        self.collectionView.backgroundView = imageViewC
    }

}
