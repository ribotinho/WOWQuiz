import UIKit

class GameViewController: UIViewController {
    
    var quiz : Quiz!
    var results = [String : Bool]()
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var questionCountLabel: UILabel!
    @IBOutlet weak var questionCategoryLabel: UILabel!
    @IBOutlet var answerButtonCollection: [UIButton]!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var progressBar: AnswerProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        loadQuestion()
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        for selectedButton in answerButtonCollection{
            if let button = selectedButton as? answerButton{
                if button.hasBeenSelected{
                    if let buttonTitle = button.titleLabel?.text{
                        results[quiz.questions[quiz.currentQuestion].title] = quiz.isSelectedAnswerCorrect(for: buttonTitle)
                        showAlert(with : quiz.isSelectedAnswerCorrect(for: buttonTitle))
                    }
                }
            }
        }
        
        
    }
    @IBAction func answerSelected(_ sender: answerButton) {
        
        for selectedButton in answerButtonCollection{
            if let button = selectedButton as? answerButton{
                if button == sender{
                    button.hasBeenSelected = true
                }else{
                    if button.hasBeenSelected == true{
                        button.hasBeenSelected = false
                    }
                }
            }
        }
        
    }
    
    //MARK: - UI
    func configureUI(){
        questionTitleLabel.numberOfLines = 0
        nextButton.layer.cornerRadius = 5
        
        for button in answerButtonCollection{
            button.layer.shadowColor = UIColor.gray.cgColor
            button.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
            button.layer.shadowOpacity = 5.0
            button.layer.shadowRadius = 5
            button.layer.masksToBounds = false
            button.layer.cornerRadius = 5.0
        }
        progressBar.quitButton.addTarget(self, action: #selector(quitButtonTapped), for: .touchUpInside)
        
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
    
    //MARK: - Quiz game
    func updateQuestionCountLabel(){
        progressBar.updateCurrentWidth()
        questionCountLabel.text = "\(quiz.currentQuestion + 1)/\(quiz.total)"
    }
    
    func loadQuestion(){
        questionCountLabel.text = "\(quiz.currentQuestion + 1)/\(quiz.total)"
        if let category = quiz.questions[quiz.currentQuestion].category, let questionTitle = quiz.questions[quiz.currentQuestion].title{
            questionCategoryLabel.text = "Category: \(category)"
            questionTitleLabel.text = "Question:\n\(questionTitle)"
        }
        
        let answers = quiz.questions[quiz.currentQuestion].answers.shuffled()
        for (index, buttons) in answerButtonCollection.enumerated(){
            if let button = buttons as? answerButton{
                button.setTitle(answers[index].title as String, for: .normal)
                button.layer.cornerRadius = 5
                button.hasBeenSelected = false
            }
        }
    }
    
    //MARK: - Alerts
    func showAlert(with answer : Bool){
        
        let storyboard = UIStoryboard(name: "Alert", bundle: .main)
        let alertVC = storyboard.instantiateViewController(identifier: AlertViewController.identifier) as! AlertViewController
        alertVC.delegate = self
        alertVC.correct = answer
        alertVC.answer = quiz.questions[quiz.currentQuestion].correction
        present(alertVC, animated: true, completion: nil)
    }
    
    
    //MARK: - Segueways
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCongratulations"{
            let destionationVC = segue.destination as! CongratulationsViewController
            destionationVC.quizResults = results
        }
    }
}

//MARK: - AlertDelegate

extension GameViewController : AlertDelegate{
    
    func didTapNextQuestion() {
        updateQuestionCountLabel()
        quiz.nextQuestion()
        if !quiz.isFinished(){
            DispatchQueue.main.async {
                self.loadQuestion()
            }
        }else{
            performSegue(withIdentifier: "toCongratulations", sender: self)
        }
    }
    
}
