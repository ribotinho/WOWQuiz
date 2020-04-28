import UIKit

class GameViewController: UIViewController {
    
    var quiz : Quiz!
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var questionCount: UILabel!
    @IBOutlet weak var answerButtonStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        loadQuestion()
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func answerSelected(_ sender: Any) {
        if let selectedButton = sender as? UIButton{
            if let buttonTitle = selectedButton.titleLabel?.text {
                configureUIAnimation(with : quiz.isSelectedAnswerCorrect(for: buttonTitle))
                quiz.nextQuestion()
                if quiz.isFinished(){
                    print("end of game")
                }else{
                    DispatchQueue.main.async {
                        self.loadQuestion()
                    }
                }
            }
        }
    }
    
    func configureUI(){
        questionTitleLabel.numberOfLines = 0
        questionTitleLabel.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        questionTitleLabel.layer.cornerRadius = 5
        updateQuestionCountLabel()
        createQuitButton()
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
        questionCount.text = "Question \(quiz.currentQuestion + 1)/\(quiz.total)"
    }
    
    func loadQuestion(){
        questionCount.text = "Question \(quiz.currentQuestion + 1)/\(quiz.total)"
        questionTitleLabel.text = quiz.questions[quiz.currentQuestion].title as String
        let answers = quiz.questions[quiz.currentQuestion].answers.shuffled()
        for (index, stackView) in answerButtonStackView.subviews.enumerated(){
            if let buttonStackView = stackView as? UIStackView{
                for button in buttonStackView.subviews{
                    if let buttonView = button as? UIButton{
                        buttonView.setTitle(answers[index].title as String, for: .normal)
                        buttonView.layer.cornerRadius = 5
                    }
                }
            }
        }
    }
    
    func configureUIAnimation(with answer : Bool){
        if answer{
            print("correct")
        }else{
            print("incorrect")
        }
    }
    
}
