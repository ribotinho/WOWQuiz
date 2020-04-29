
import UIKit

class AlertViewController: UIViewController {
    
    var delegate : AlertDelegate?
    var correct : Bool!
    var answer : String!
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

        bodyLabel.text = answer
        backView.layer.cornerRadius = 5
        
        if correct{
            checkImageView.image = UIImage(systemName: "checkmark.circle")
            checkImageView.tintColor = .systemGreen
            headerTitleLabel.text = "CORRECT!"
            headerTitleLabel.textColor = .systemGreen
            nextButton.setTitle("NEXT QUESTION", for: .normal)
            nextButton.backgroundColor = .systemGreen
        }else{
            checkImageView.image = UIImage(systemName: "multiply.circle")
            checkImageView.tintColor = .systemRed
            headerTitleLabel.text = "INCORRECT!"
            headerTitleLabel.textColor = .systemRed
            nextButton.setTitle("TRY AGAIN", for: .normal)
            nextButton.backgroundColor = .systemRed
        }
    }
    
    @IBAction func nextQuesstionButtonTapped(_ sender: Any) {
        if correct{
            dismiss(animated: true, completion: nil)
            delegate?.didTapNextQuestion()
        }else{
            dismiss(animated: true, completion: nil)
            delegate?.didFailQuestion()
        }
    }
    
}

protocol AlertDelegate {
    func didTapNextQuestion()
    func didFailQuestion()
}
