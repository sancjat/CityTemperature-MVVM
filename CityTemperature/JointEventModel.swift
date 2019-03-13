

import UIKit
import CoreData

class JointEventModel: NSObject {
  
    var RowID : NSNumber!
    var RowName : String!
    var RowImage : String!
    var RowMaxTemp : String!
    var RowMinTemp   : String!
    var RowTemp : String!
    var Rowhumidity : String!
    var Rowdescription : String!
    var arrofdata = [NSManagedObject]()
    
    class func getvaluesOfSelectTemp(arrOfListData : NSArray)-> [JointEventModel]
    {
        var selectTempModelArray = [JointEventModel]()
        
        for index in 0..<arrOfListData.count
        {
            let aboutModel:JointEventModel  =  JointEventModel()
            let dict = arrOfListData.object(at: index) as! NSDictionary
            let maindict = dict.value(forKey: "main") as! NSDictionary
            let weatherdict = (dict.value(forKey: "weather") as! NSArray)[0] as! NSDictionary
            aboutModel.RowID = dict.value(forKey: "id") as? NSNumber
            aboutModel.RowName = "\((dict.value(forKey: "name")) ?? "")"
            aboutModel.RowMaxTemp = "\((maindict.value(forKey: "temp_max")) ?? "")"
            aboutModel.RowMinTemp = "\((maindict.value(forKey: "temp_min")) ?? "")"
            aboutModel.RowTemp = "\((maindict.value(forKey: "temp")) ?? "")"
            aboutModel.Rowhumidity = "\((maindict.value(forKey: "humidity")) ?? "")"
            aboutModel.Rowdescription = "\((weatherdict.value(forKey: "description")) ?? "")"
            selectTempModelArray.append(aboutModel)
        }
        
        return selectTempModelArray
    }
    
    class func MakeTableView() -> [NSManagedObject]
    {
        let tempModel:TempModel  =  TempModel()
        
        return tempModel.retrieveData()
    }
    
    
    class func setTemp()  {
        
        let remoteHostStatusIntrnet:Bool   = obj_app.checkNetworkStatus()
        
        obj_app.startActivity()
        
        if remoteHostStatusIntrnet == true
        {
            //http://api.openweathermap.org/data/2.5/weather?id=4163971&APPID=a8a6aa00e32ba6ca3ab30aecc084fd90
            let urlArr = ["http://api.openweathermap.org/data/2.5/weather?id=4163971&APPID=a8a6aa00e32ba6ca3ab30aecc084fd90","http://api.openweathermap.org/data/2.5/weather?id=2147714&APPID=a8a6aa00e32ba6ca3ab30aecc084fd90","http://api.openweathermap.org/data/2.5/weather?id=2174003&APPID=a8a6aa00e32ba6ca3ab30aecc084fd90"]
            let allTempValue = NSMutableArray()
            
            for i in urlArr {
                
                DispatchQueue.main.async(execute: { () -> Void in
                    do
                    {
                        let _ = URLSession.shared.dataTask(with: URL(string: i)!, completionHandler: { (data : Data? , resp : URLResponse? , error: Error?) -> Void in
                            if let jsondata = data {
                                let jsonBase = try? JSONSerialization.jsonObject(with: jsondata, options: JSONSerialization.ReadingOptions.mutableContainers)
                                print(jsonBase as! NSDictionary)
                                
                                allTempValue.add(jsonBase as! NSDictionary)
                                
                                if allTempValue.count == 3 {
                                    obj_app.stopAcitivity()
                                    DispatchQueue.main.async {
                                        let ModelClassArray = JointEventModel.getvaluesOfSelectTemp(arrOfListData: allTempValue)
                                        print(ModelClassArray)
                                        let tempModel = TempModel()
                                        tempModel.deleteData()
                                       tempModel.createData(ModelClassArray)
                                    }
                                }
                            }
                        }).resume()
                    }
                    catch
                    {
                        obj_app.stopAcitivity()
                        print(error)
                        
                    }
                })
                
            }
            
        }
        else
        {
            obj_app.stopAcitivity()
            obj_app.alertViewFromApp(messageString: "No Network available in device ,please try to connect with internet!")
        }
        
        
    }
    
    
    
}

