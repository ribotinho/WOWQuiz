
import UIKit
import UICircularProgressRing

class CongratulationsViewController: UIViewController {
    
    
    @IBOutlet weak var resultsRing: UICircularProgressRing!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var midLabel: UILabel!
    var correctAnswers : Int?
    let totalAnswers = 15
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureProgressRing()
    }
    
    func configureUI(){
        
        backButton.setTitle("PLAY AGAIN", for: .normal)
        backButton.backgroundColor = .red
        backButton.layer.shadowColor = UIColor.white.cgColor
        backButton.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        backButton.layer.shadowOpacity = 5.0
        backButton.layer.shadowRadius = 5
        backButton.layer.masksToBounds = false
        backButton.layer.cornerRadius = 5.0
        topLabel.alpha = 0
        midLabel.isHidden = true
        backButton.isHidden = true
    }
    
    func configureProgressRing(){
        resultsRing.delegate = self
        //formatter
        var formatter = UICircularProgressRingFormatter()
        formatter.valueIndicator = "/\(totalAnswers)"
        resultsRing.valueFormatter = formatter
        
        resultsRing.font = UIFont(name: "Futura", size: 20.0)!
        
        //style
        resultsRing.style = .ontop
        resultsRing.innerCapStyle = .round
        
        //color
        resultsRing.innerRingColor = .orange
        resultsRing.outerRingColor = UIColor.gray.withAlphaComponent(0.5)
        resultsRing.backgroundColor = .clear
        
        //width
        resultsRing.innerRingWidth = 35
        resultsRing.outerRingWidth = 40
        
        //angles in degrees - 270 top and 90 bottom
        resultsRing.startAngle = 270
        
        //values
        resultsRing.maxValue = CGFloat(totalAnswers)
        if let progress = correctAnswers {
            configureMessage()
            resultsRing.startProgress(to: CGFloat(progress), duration: 2.0, completion: { () in
                self.drawMessage()
            })
        }
    }
    
    private func drawMessage(){
        
        UIView.animate(withDuration: 1, animations: {
            self.topLabel.alpha = 1
            self.topLabel.transform = CGAffineTransform(scaleX: 2, y: 2)
        }) { (error) in
            UIView.animate(withDuration: 0.3, animations: {
                self.topLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
            }) { (error) in
                self.topLabel.transform = CGAffineTransform(translationX: 20, y: 0)
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    self.topLabel.transform = CGAffineTransform.identity
                }) { (error) in
                    self.midLabel.isHidden = false
                    self.backButton.isHidden = false
                }
            }
        }
    }
    
    private func configureMessage(){
        if let correct = correctAnswers{
            if correct < 5{
                topLabel.text = "KEEP TRYING"
                midLabel.text = "You have still a lot to learn from this magnific game: World of Warcraft.\n\nKeep playing to earn a higher score and discover new hidden questions.\n\nIf you have any suggestions to make this quiz even better, please don't hesitate to send us an email to contact@pauribot.com"
            }
            else if correct > 5 && correct < 10 {
                topLabel.text = "GREAT JOB!"
                midLabel.text = "You have done a great job in this quiz and it's noticable that you are very knowledgeable in this game: World of Warcraft.\n\nKeep playing to earn a higher score and discover new hidden questions.\n\nIf you have any suggestions to make this quiz even better, please don't hesitate to send us an email to contact@pauribot.com"
            }else if correct > 10 && correct < 15{
                topLabel.text = "CONGRATULATIONS!"
                midLabel.text = "You are a real expert on Word of Warcraft but there's a few questions that you missed.\n\nKeep playing to earn the highest score and discover new hidden questions\n\nIf you have any suggestions to make this quiz even better, please don't hesitate to send us an email to contact@pauribot.com"
            }else{
                topLabel.text = "INCREDIBLE!"
                midLabel.text = "Congratulations! You are an avid player of World of Warcraft and you have earned the highest score!\n\nKeep playing to discover new hidden questions\n\nIf you have any suggestions to make this quiz even better, please don't hesitate to send us an email to contact@pauribot.com"
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Delegate: UICircularProgressRingDelegate

extension CongratulationsViewController : UICircularProgressRingDelegate{
    
    func didUpdateProgressValue(for ring: UICircularProgressRing, to newValue: CGFloat) {
        if newValue < 5{
            ring.innerRingColor = .red
        }
        else if newValue > 5 && newValue < 10 {
            ring.innerRingColor = .yellow
        }else{
            ring.innerRingColor = .green
        }
    }
    
    //Methods that are currently not used
    func didFinishProgress(for ring: UICircularProgressRing) {
        
    }
    
    func didPauseProgress(for ring: UICircularProgressRing) {
        
    }
    
    func didContinueProgress(for ring: UICircularProgressRing) {
        
    }
    
    func willDisplayLabel(for ring: UICircularProgressRing, _ label: UILabel) {
        
    }
    
}


