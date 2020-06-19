//
//  ViewController.swift
//  nocat
//
//  Created by Onuorah Nwachukwu on 11/06/2020.
//  Copyright © 2020 Onuorah Nwachukwu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate {

     // MARK: Outlets
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var myPickerView: UIPickerView!
    let myPickerData = [String](arrayLiteral: "user1","user2","user3","user4")
    // MARK: Variables
      var feedUsers: [nocatUser] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return dailyTasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        cell.textLabel?.text = dailyTasks[indexPath.row]
        return cell
    }
    
    //Data source methods
       //  Create [String] arrays of tasks
       let dailyTasks = ["windows",
                         "doors",
                         "boiler?",
                         "mailbox",
                         "containers",
                         "pipes",
                         "occurrences",]
       
         

    @IBAction func refreshUsers(_ sender: Any) {
        view.backgroundColor = UIColor.red
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        myPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let _:String = myPickerData[row]
        NetworkDataService.shared.getUsers { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    
                    self.feedUsers = users
                    self.usersTableView.reloadData()
                    
                    for user in users {
                        print("\(user)\n")
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myPickerView.delegate = self
    
    }
}

