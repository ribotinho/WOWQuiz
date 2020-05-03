import UIKit

class GameViewController: UIViewController {
    
    var quiz : Quiz!
    var results = [String : Bool]()
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var questionBackgroundImageView: UIImageView!
    @IBOutlet weak var nextButtonView: NextButton!
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet var answerButtonCollection: [UIButton]!
    @IBOutlet weak var progressBar: AnswerProgressView!
    @IBOutlet weak var questionBackgroundView: UIView!
    @IBOutlet weak var questionCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        loadQuestion()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        
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
        view.backgroundColor = K.Colors.grayQuest
        questionBackgroundImageView.layer.cornerRadius = 15
        questionTitleLabel.numberOfLines = 0
        progressBar.quitButton.addTarget(self, action: #selector(quitButtonTapped), for: .touchUpInside)
        questionBackgroundView.layer.cornerRadius = 25
        questionBackgroundView.backgroundColor = .clear
        //questionBackgroundView.layer.borderColor = K.Colors.yellow.cgColor
        //questionBackgroundView.layer.borderWidth = 3
        questionBackgroundView.layer.shadowColor = K.Colors.darkBlue.cgColor
        questionBackgroundView.layer.shadowOffset = .zero
        questionBackgroundView.layer.shadowRadius = 15
        questionBackgroundView.layer.shadowOpacity = 0.8
        
        nextButtonView.button.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        
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
        questionCountLabel.text = "Question \(quiz.currentQuestion + 1) of \(quiz.total)"
        categoryLabel.text = quiz.questions[quiz.currentQuestion].category
        progressBar.updateCurrentWidth()
    }
    
    func loadQuestion(){
        if let questionTitle = quiz.questions[quiz.currentQuestion].title{
            questionTitleLabel.text = questionTitle
            questionCountLabel.text = "Question \(quiz.currentQuestion + 1) of \(quiz.total)"
            categoryLabel.text = quiz.questions[quiz.currentQuestion].category.uppercased()
        }
        
        let answers = quiz.questions[quiz.currentQuestion].answers.shuffled()
        for (index, buttons) in answerButtonCollection.enumerated(){
            if let button = buttons as? answerButton{
                button.setTitle(answers[index].title as String, for: .normal)
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
