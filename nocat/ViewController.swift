//
//  ViewController.swift
//  nocat
//
//  Created by Onuorah Nwachukwu on 11/06/2020.
//  Copyright © 2020 Onuorah Nwachukwu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {

    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
           cell.textLabel?.text = dailyTasks[indexPath.row]
            return cell
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return dailyTasks.count
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

