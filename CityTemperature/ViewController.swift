//
//  ViewController.swift
//  CityTemperature
//
//  Created by Santosh Kumari on 11/03/19.
//  Copyright © 2019 Santosh Kumari. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var arrofdata = [NSManagedObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        JointEventModel.setTemp()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  arrofdata.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! TableCell
        let innerdata = arrofdata[indexPath.row]
        cell.cityname.text = innerdata.value(forKey: "name") as? String
        cell.templabel.text = innerdata.value(forKey: "temperature") as? String
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict = arrofdata[indexPath.row]
        let storybd = UIStoryboard.init(name: "Main", bundle: nil)
        let DetailsVC : DetailController = storybd.instantiateViewController(withIdentifier: "DetailController") as! DetailController
        DetailsVC.arrofDict = dict
        self.navigationController?.pushViewController(DetailsVC, animated: true)
    }
    
    
    @IBAction func RefreshTableView(_ sender: UIBarButtonItem) {
        JointEventModel.setTemp()
    }
    
   

}

