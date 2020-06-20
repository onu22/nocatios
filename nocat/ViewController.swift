
import UIKit

class ViewController: UIViewController,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate {

     // MARK: Outlets
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var myPickerView: UIPickerView!
    // MARK: Variables
      var feedUsers: [nocatUser] = []
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedUsers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let currentUser = self.feedUsers[indexPath.row]
        cell.textLabel?.text = currentUser.userName
        cell.detailTextLabel?.text = currentUser.deviceId
        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
        return  self.feedUsers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //call updateLocation
        //then call nearbys to fetch neighbours
        self.feedUsers[row].userName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let _ :nocatUser = self.feedUsers[row]
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myPickerView.delegate = self
        NetworkDataService.shared.getUsers { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    
                    self.feedUsers = users
                    self.usersTableView.reloadData()
                    self.myPickerView.reloadAllComponents()
                case .failure(let error):
                    print(error)
                }
            }
        }
    
    }
}

