
import UIKit
import UICircularProgressRing

class CongratulationsViewController: UIViewController {
    
    
    @IBOutlet weak var resultsRing: UICircularProgressRing!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var topLabel: UILabel!
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
        
        backButton.setTitle("TRY AGAIN", for: .normal)
        backButton.backgroundColor = .lightGray
        backButton.layer.shadowColor = UIColor.gray.cgColor
        backButton.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        backButton.layer.shadowOpacity = 5.0
        backButton.layer.shadowRadius = 5
        backButton.layer.masksToBounds = false
        backButton.layer.cornerRadius = 5.0
        topLabel.alpha = 0
    }
    
    func configureProgressRing(){
        correctAnswers = 12
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
                    }, completion: nil)
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


