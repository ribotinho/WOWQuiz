
import UIKit

class AlertViewController: UIViewController {
    
    var delegate : AlertDelegate?
    var correct : String!
    var answer : String!
    var isLast : Bool!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    static let identifier = "AlertVC"

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        
        headerView.backgroundColor = .clear
        checkImageView.layer.cornerRadius = checkImageView.frame.size.width / 2
        checkImageView.clipsToBounds = true
        nextButton.layer.cornerRadius = 5
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.setTitle(isLast ? "VIEW RESULTS" : "NEXT QUESTION", for: .normal)
        nextButton.backgroundColor = .secondarySystemBackground
        bodyLabel.text = answer
        backView.layer.cornerRadius = 15
        
        if correct == "Correct" {
            checkImageView.image = UIImage(systemName: "checkmark.circle")
            checkImageView.tintColor = .systemGreen
            headerTitleLabel.text = "CORRECT!"
            headerTitleLabel.textColor = .systemGreen
            
        }else if correct == "False" {
            checkImageView.image = UIImage(systemName: "multiply.circle")
            checkImageView.tintColor = .systemRed
            headerTitleLabel.text = "INCORRECT!"
            headerTitleLabel.textColor = .systemRed
            
        }else{
            checkImageView.image = UIImage(systemName: "timer")
            checkImageView.tintColor = .systemRed
            headerTitleLabel.text = "TIME'S UP!"
            headerTitleLabel.textColor = .systemRed
        }
    }
    
    @IBAction func nextQuesstionButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.didTapNextQuestion()
    }
}

protocol AlertDelegate {
    func didTapNextQuestion()
}
