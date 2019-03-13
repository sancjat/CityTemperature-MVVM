//
//  DetailController.swift
//  CityTemperature
//
//  Created by Santosh Kumari on 12/03/19.
//  Copyright © 2019 Santosh Kumari. All rights reserved.
//

import UIKit
import CoreData

class DetailController: UIViewController {

    var arrofDict = NSManagedObject()
    @IBOutlet weak var EventTitleLbl: UILabel!
    @IBOutlet weak var EventDescriptionLbl: UILabel!
    @IBOutlet weak var EventMaxTempLbl: UILabel!
    @IBOutlet weak var EventMinTempLbl: UILabel!
    @IBOutlet weak var eventhumidityLbl: UILabel!
    @IBOutlet weak var EventTempLbl: UILabel!
  
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MakeScreenView()
        // Do any additional setup after loading the view.
    }
    
    
    
    func MakeScreenView()  {
        
        EventTitleLbl.text = arrofDict.value(forKey: "name") as? String
        EventDescriptionLbl.text = "Its climate is \(arrofDict.value(forKey: "weatherdescription") ?? "" )"
        EventMaxTempLbl.text = "Its max temperature is: \(arrofDict.value(forKey: "maxtemp") ?? "" )"
        EventMinTempLbl.text = "Its min temperature is: \(arrofDict.value(forKey: "mintemp") ?? "" )"
        eventhumidityLbl.text = "Its humidity in temperature is: \(arrofDict.value(forKey: "humidity") ?? "" )"
        EventTempLbl.text = "Its temperature is: \(arrofDict.value(forKey: "temperature") ?? "" )"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
