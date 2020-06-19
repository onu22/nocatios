//
//  ViewController.swift
//  nocat
//
//  Created by Onuorah Nwachukwu on 11/06/2020.
//  Copyright © 2020 Onuorah Nwachukwu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {

     // MARK: Outlets
    @IBOutlet weak var usersTableView: UITableView!
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // TODO: GET a list of gists
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


}

