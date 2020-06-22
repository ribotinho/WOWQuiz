
import UIKit
import UICircularProgressRing

class CongratulationsViewController: UIViewController {
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var topLabel: UILabel!
    var correctAnswers : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //configureProgressRing()
    }

    func configureUI(){
        
        backButton.setTitle("TRY AGAIN", for: .normal)
        backButton.backgroundColor = .lightGray
        backButton.layer.shadowColor = UIColor.gray.cgColor
        backButton.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        backButton.layer.shadowOpacity = 5.0
        backButton.layer.shadowRadius = 5
        backButton.layer.masksToBounds = false
        backButton.layer.cornerRadius = 5.0
        
    }
    
    /*func configureProgressRing(){
        resultsRing.style = .inside
        resultsRing.maxValue = 15
        resultsRing.backgroundColor = .clear
        resultsRing.startProgress(to: 6.0, duration: 1.0)
        
        /*if let progress = correctAnswers {
            resultsRing.startProgress(to: CGFloat(progress), duration: 1.0)
        }*/
    }*/
    
    @IBAction func backButtonTapped(_ sender: Any) {
    }
}


