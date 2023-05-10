//
//  CoreDataManager.swift
//  SportsApp
//
//  Created by Huda kamal  on 09/05/2023.
//

import Foundation
import CoreData

protocol InsertedTeam{
    func insertTeam()
}

class CoreDataManager  {
    static let dataBase = CoreDataManager()
    
    var context:NSManagedObjectContext!
    var teamsObjects:[NSManagedObject]!
    
    var insertDelegate: InsertedTeam?
    
    
    func SaveTeamToDB(context : NSManagedObjectContext , team : Team){
        
        let entity = NSEntityDescription.entity(forEntityName: "FavDB", in: context)!
        let teamObj = NSManagedObject(entity: entity, insertInto: context)
        
        teamObj.setValue(team.teamName, forKey: "teamName")
        teamObj.setValue(team.teamId, forKey: "teamId")
        
        do{
            try context.save()
            print("Successful insert")
            insertDelegate?.insertTeam()
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    func getTeamsFromDB(context:NSManagedObjectContext) ->[Team]{
        
        var teams = [Team]()
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "FavDB")
        do{
            teamsObjects = try context.fetch(fetchReq)
            for team in teamsObjects{
                let teamId   = team.value(forKey: "teamId")  as! Int
                let teamName = team.value(forKey: "teamName") as! String
                teams.append(Team(teamId: teamId,teamName: teamName))
            }
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        return teams
    }
    
    func checkIfDBIsEmpty(context : NSManagedObjectContext)-> Bool{
        var isEmpty = true
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "FavDB")
        do{
            teamsObjects = try context.fetch(fetchReq)
            
            if(teamsObjects.count > 0){
                isEmpty = false
            }
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        return isEmpty
    }
    
    func deleteTeamFromDB(context:NSManagedObjectContext , team : Team){
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "FavDB")
        
        let predicate = NSPredicate(format: "teamName == %@", team.teamName)
        fetchReq.predicate = predicate
        
        do{
            teamsObjects = try context.fetch(fetchReq)
            context.delete(teamsObjects[0])
            try context.save()
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
}





//class DatabaseManager {

//    func saveEmployeeToDB(context: NSManagedObjectContext, employee: MyEmployee){
//
//        let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context)!
//
//        let emp = NSManagedObject(entity: entity, insertInto: context)
//
//        emp.setValue(employee.id, forKey: "id")
//        emp.setValue(employee.employee_name, forKey: "employee_name")
//        emp.setValue(employee.profile_image, forKey: "profile_image")
//
//        if employee.profileImageData != nil {
//            emp.setValue(employee.profileImageData, forKey: "profileImageData")
//        }
//
//        do{
//            try context.save()
//            print("Successful insert")
//            delegateInsert?.insertedRowSuccessfully()
//        } catch let error as NSError{
//            print(error.localizedDescription)
//        }
//
//
//    }


//
//    func getEmployeesFromDB(context: NSManagedObjectContext) -> [MyEmployee]{
//
//        var employees = [MyEmployee]()
//
//        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Employee")
//        do{
//            empObjects = try context.fetch(fetchReq)
//
//
//            for emp in empObjects {
//                let id = emp.value(forKey: "id") as! Int
//                let name = emp.value(forKey: "employee_name") as! String
//                let age = emp.value(forKey: "employee_age") as! Int
//                let salary = emp.value(forKey: "employee_salary") as! Int
//                let profile_image = emp.value(forKey: "profile_image") as! String
//                let profileImageData = emp.value(forKey: "profileImageData") as? Data
//
//                employees.append(MyEmployee(id: id, employee_name: name, employee_salary: salary, employee_age: age, profile_image: profile_image, profileImageData: profileImageData))
//            }
//
//        } catch let error as NSError{
//            print(error.localizedDescription)
//        }
//
//
//        return employees
//
//    }


//
//    func checkIfDBIsEmpty(context: NSManagedObjectContext) -> Bool{
//
//        var isEmpty = true
//
//        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Employee")
//        do{
//            empObjects = try context.fetch(fetchReq)
//
//            if (empObjects.count > 0){
//                isEmpty = false
//            }
//
//        } catch let error as NSError{
//            print(error.localizedDescription)
//        }
//
//        return isEmpty
//    }

//
//
//    func deleteEmployee(context: NSManagedObjectContext, emp: MyEmployee){
//
//        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Employee")
//        let predicate = NSPredicate(format: "employee_name == %@", emp.employee_name)
//        fetchReq.predicate = predicate
//
//        do{
//            empObjects = try context.fetch(fetchReq)
//            context.delete(empObjects[0])
//            try context.save()
//            delegateDelete?.deletedRowSuccessfully()
//        } catch let error as NSError{
//            print(error.localizedDescription)
//        }
//
//    }
//}
//
