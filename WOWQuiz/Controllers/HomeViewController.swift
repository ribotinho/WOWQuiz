import RealmSwift
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var startGameButon: UIButton!
    var quizGame : Quiz{
        let questions = DatabaseManager.sharedInstance.getDataFromDB()
        let quizGame = Quiz(with: questions)
        return quizGame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //DatabaseManager.sharedInstance.populateQuestion()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        navigationController?.navigationBar.isHidden = true
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "startGameSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGameSegue"{
            let destionationVC = segue.destination as! GameViewController
            destionationVC.quiz = quizGame
        }
    }
    
    private func configureUI(){
        startGameButon.backgroundColor = .red
        startGameButon.setTitle("START GAME", for: .normal)
        startGameButon.layer.cornerRadius = 10
        
        startGameButon.layer.shadowColor = UIColor.white.cgColor
        startGameButon.layer.shadowOpacity = 10
        startGameButon.layer.shadowRadius = 15
    }

}
