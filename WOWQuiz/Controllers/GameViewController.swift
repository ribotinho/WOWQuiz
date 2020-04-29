import UIKit

class GameViewController: UIViewController {
    
    var quiz : Quiz!
    var timer : Timer!
    var runCount : Int = 30{
        didSet{
            timerLabel.text = String(runCount)
        }
    }
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var questionCountLabel: UILabel!
    @IBOutlet weak var questionCategoryLabel: UILabel!
    @IBOutlet weak var answerButtonStackView: UIStackView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet var answerButtonCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        loadQuestion()
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func answerSelected(_ sender: Any) {
        stopTimer()
        if let selectedButton = sender as? UIButton{
            if let buttonTitle = selectedButton.titleLabel?.text {
                showAlert(with : quiz.isSelectedAnswerCorrect(for: buttonTitle))
            }
        }
    }
    
    func configureUI(){
        questionTitleLabel.numberOfLines = 0
        questionTitleLabel.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        updateQuestionCountLabel()
        createQuitButton()
        startTimer()
    }
    
    
    
    func createQuitButton(){
        let quitButton = UIButton()
        view.addSubview(quitButton)
        quitButton.translatesAutoresizingMaskIntoConstraints = false
        quitButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        quitButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        quitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        quitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        quitButton.setBackgroundImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
        quitButton.tintColor = .black
        quitButton.addTarget(self, action: #selector(quitButtonTapped), for: .touchUpInside)
    }
    
    @objc func quitButtonTapped( _ sender : UIButton){
        let alert = UIAlertController(title: "Quit Game", message: "Are you sure you want to quit?", preferredStyle: .alert)
        let quitAction = UIAlertAction(title: "Quit", style: .destructive) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(quitAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func updateQuestionCountLabel(){
        questionCountLabel.text = "\(quiz.currentQuestion + 1)/\(quiz.total)"
    }
    
    func loadQuestion(){
        questionCountLabel.text = "\(quiz.currentQuestion + 1)/\(quiz.total)"
        if let category = quiz.questions[quiz.currentQuestion].category, let questionTitle = quiz.questions[quiz.currentQuestion].title{
            questionCategoryLabel.text = "Category: \(category)"
            questionTitleLabel.text = "Question:\n\(questionTitle)"
        }
        
        let answers = quiz.questions[quiz.currentQuestion].answers.shuffled()
        for (index, answerButton) in answerButtonCollection.enumerated(){
            answerButton.setTitle(answers[index].title as String, for: .normal)
            answerButton.layer.cornerRadius = 5
        }

    }
    
    //MARK: - Alerts
    func showAlert(with answer : Bool){
        
        stopTimer()
        let storyboard = UIStoryboard(name: "Alert", bundle: .main)
        let alertVC = storyboard.instantiateViewController(identifier: AlertViewController.identifier) as! AlertViewController
        alertVC.delegate = self
        alertVC.correct = answer
        present(alertVC, animated: true, completion: nil)
        
        if answer{
            print("correct") // showing above alert
        }else{
            //need to present another VC
            print("incorrect")
        }
    }
    
    
    //MARK: - Timer
    func stopTimer(){
        timer.invalidate()
        runCount = 30
    }
    
    func startTimer(){
        timerLabel.text = "30"
        timerLabel.sizeToFit()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            self.runCount -= 1
            
            if self.runCount == 0{
                print("Time expired")
                timer.invalidate()
            }
        }
    }
}

//MARK: - AlertDelegate

extension GameViewController : AlertDelegate{
    
    func didTapNextQuestion() {
        quiz.nextQuestion()
        if quiz.isFinished(){
            print("end of game")
        }else{
            print("next question")
            DispatchQueue.main.async {
                self.loadQuestion()
                self.startTimer()
            }
        }
    }
    
    func didFailQuestion() {
        navigationController?.popViewController(animated: true)
    }
    
}
