
import UIKit

class CongratulationsViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var quizResults : [String : Bool]?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        configureUI()
    }
    
    func configureUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 5
        
        backButton.setTitle("TRY AGAIN", for: .normal)
        backButton.backgroundColor = .lightGray
        backButton.layer.shadowColor = UIColor.gray.cgColor
        backButton.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        backButton.layer.shadowOpacity = 5.0
        backButton.layer.shadowRadius = 5
        backButton.layer.masksToBounds = false
        backButton.layer.cornerRadius = 5.0
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
    }
}

extension CongratulationsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizResults!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath)
        if let results = quizResults{
            let keys = Array(results.keys)
            let values = Array(results.values)
            
            cell.textLabel?.text = keys[indexPath.row]
            cell.layer.backgroundColor = UIColor.clear.cgColor
            if values[indexPath.row]{
                cell.imageView?.image = UIImage(systemName: "checkmark")
                cell.imageView?.tintColor = .green
            }else{
                cell.imageView?.image = UIImage(systemName: "multiply")
                cell.imageView?.tintColor = .red
            }
            
        }
        return cell
    }
}
