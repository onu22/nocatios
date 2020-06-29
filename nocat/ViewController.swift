
import UIKit

class ViewController: UIViewController,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate {

     // MARK: Outlets
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var myPickerView: UIPickerView!
    // MARK: Variables
      var feedUsers: [nocatUser] = []
      var feedNeighbours: [nocatUser] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedNeighbours.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let currentUser = self.feedNeighbours[indexPath.row]
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
        self.feedUsers[row].userName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let userno :nocatUser = self.feedUsers[row]
        
        //then call nearbys to fetch neighbours
        NetworkDataService.shared.getNeighbours(user: userno) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self.feedNeighbours = users
                    self.usersTableView.reloadData()
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
        NetworkDataService.shared.getUsers { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self.feedUsers = users
                   // self.usersTableView.reloadData()
                    self.myPickerView.reloadAllComponents()
                case .failure(let error):
                    print(error)
                }
            }
        }
    
    }
}

