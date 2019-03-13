//
//  TempModel.swift
//  CityTemperature
//
//  Created by Santosh Kumari on 13/03/19.
//  Copyright © 2019 Santosh Kumari. All rights reserved.
//

import UIKit
import CoreData

class TempModel: NSObject {
    
    var arrofdata = [NSManagedObject]()
    var result  = [NSManagedObject]()
    let managedContext = obj_app.persistentContainer.viewContext


    func createData(_ modelclassArray : [JointEventModel]) {
        
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "City", in: managedContext)!
        
        for i in 0..<modelclassArray.count {
            let objmodel = modelclassArray[i]
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue(objmodel.RowName, forKeyPath: "name")
            user.setValue(objmodel.RowMaxTemp, forKey: "maxtemp")
            user.setValue(objmodel.RowMinTemp, forKey: "mintemp")
            user.setValue(objmodel.RowTemp, forKey: "temperature")
            user.setValue(objmodel.Rowhumidity, forKey: "humidity")
            user.setValue(objmodel.Rowdescription, forKey: "weatherdescription")
            arrofdata.append(user)
        }
        
        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    
    }
    
    func deleteData(){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
       
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            for managedObject in test
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
    }
    
    
    func retrieveData()-> [NSManagedObject]  {
        
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
       
        do {
            
            result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            print(result)

        } catch {
            
            print("Failed")
        }
        
        return result
        
    }
    
    
    
}
