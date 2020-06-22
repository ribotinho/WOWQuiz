import UIKit

class GameViewController: UIViewController {
    
    var quiz : Quiz!
    var correctAnswers = 0
    var timer : Timer?
    var runCount = 30
    var answerButtonStackView : UIStackView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var questionBackgroundImageView: UIImageView!
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var questionBackgroundView: UIView!
    @IBOutlet weak var questionCountLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadQuestion()
        navigationController?.navigationBar.isHidden = true
    }
    
    
    @objc func answerSelected(_ sender: answerButton) {
        
        if let currentTimer = timer{
            currentTimer.invalidate()
            runCount = 30
            progressBar.progress = 1.0
        }
        if let buttonTitle = sender.titleLabel?.text{
            sender.blink(for: quiz.isSelectedAnswerCorrect(for: buttonTitle))
            if quiz.isSelectedAnswerCorrect(for: buttonTitle){
                correctAnswers += 1
                print("correct: \(correctAnswers)")
                showAlert(with : "Correct")
            }else{
                showAlert(with : "False")
            }
            
        }
    }
    
    //MARK - timer
    
    func configureTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.runCount -= 1
            if self.runCount > 0 {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 1.0) {
                        self.progressBar.setProgress(Float(self.runCount)/Float(30), animated: true)
                    }
                    
                }
            }else{
                timer.invalidate()
                self.showAlert(with: "time")
                self.runCount = 30
                self.progressBar.progress = 1.0
            }
        })
    }
    
    //MARK: - UI
    func configureUI(){
        view.backgroundColor = K.Colors.grayQuest
        questionBackgroundImageView.layer.cornerRadius = 15
        questionTitleLabel.numberOfLines = 0
        configureQuestionBackgroundView()
        configureProgressBar()
        configureQuitButton()
        configureAnswerButtons()
    }
    
    fileprivate func configureAnswerButtons(){
        
        var buttons = [answerButton]()
        
        for _ in 0..<4{
            let button = answerButton(frame: .zero)
            button.addTarget(self, action: #selector(answerSelected(_:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        answerButtonStackView = UIStackView(arrangedSubviews: buttons)
        answerButtonStackView.axis = .vertical
        answerButtonStackView.spacing = 15
        answerButtonStackView.distribution = .equalSpacing
        questionBackgroundView.addSubview(answerButtonStackView)
        answerButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        answerButtonStackView.leadingAnchor.constraint(equalTo: questionBackgroundView.leadingAnchor).isActive = true
        answerButtonStackView.trailingAnchor.constraint(equalTo: questionBackgroundView.trailingAnchor).isActive = true
        answerButtonStackView.bottomAnchor.constraint(equalTo: questionBackgroundView.bottomAnchor).isActive = true
        
        
        for button in answerButtonStackView.subviews{
            if let newButton = button as? answerButton{
                newButton.translatesAutoresizingMaskIntoConstraints = false
                newButton.leadingAnchor.constraint(equalTo: answerButtonStackView.leadingAnchor).isActive = true
                newButton.trailingAnchor.constraint(equalTo: answerButtonStackView.trailingAnchor).isActive = true
                newButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
            }
        }
    }
    
    fileprivate func configureQuitButton(){
        let quitButton = UIButton()
        view.addSubview(quitButton)
        quitButton.translatesAutoresizingMaskIntoConstraints = false
        quitButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        quitButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        quitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        quitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        quitButton.setBackgroundImage(UIImage(systemName: "multiply.circle"), for: .normal)
        quitButton.tintColor = .black
        quitButton.addTarget(self, action: #selector(quitButtonTapped), for: .touchUpInside)
    }
    
    fileprivate func configureProgressBar(){
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 8)
        progressBar.progress = 1.0
        
        progressBar.layer.cornerRadius = 10
        progressBar.clipsToBounds = true
        progressBar.layer.sublayers![1].cornerRadius = 10
        progressBar.subviews[1].clipsToBounds = true
        
        progressBar.trackTintColor = .white
        let gradientImage = UIImage.gradientImage(with: progressBar.frame, colors: [UIColor.red.cgColor, K.Colors.yellow.cgColor], locations: nil)
        progressBar.progressImage = gradientImage!
    }
    
    fileprivate func configureQuestionBackgroundView() {
        questionBackgroundView.backgroundColor = .clear
        /*questionBackgroundView.layer.cornerRadius = 25
        questionBackgroundView.layer.shadowColor = UIColor.black.cgColor
        questionBackgroundView.layer.shadowOffset = .zero
        questionBackgroundView.layer.shadowRadius = 15
        questionBackgroundView.layer.shadowOpacity = 0.8*/
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
    }
    
    func loadQuestion(){
        if let questionTitle = quiz.questions[quiz.currentQuestion].title{
            questionTitleLabel.text = questionTitle
            questionCountLabel.text = "Question \(quiz.currentQuestion + 1) of \(quiz.total)"
            categoryLabel.text = quiz.questions[quiz.currentQuestion].category.uppercased()
        }
        
        let answers = quiz.questions[quiz.currentQuestion].answers.shuffled()
        for (index, buttons) in answerButtonStackView!.subviews.enumerated(){
            if let button = buttons as? answerButton{
                button.reset()
                button.setTitle(answers[index].title as String, for: .normal)
            }
        }
        configureTimer()
    }
    
    //MARK: - Alerts
    func showAlert(with answer : String){
        
        let storyboard = UIStoryboard(name: "Alert", bundle: .main)
        let alertVC = storyboard.instantiateViewController(identifier: AlertViewController.identifier) as! AlertViewController
        let delay = (answer == "time") ? 0.0 : 2.0
        alertVC.delegate = self
        alertVC.isLast = (quiz.currentQuestion + 1  == quiz.total) ? true : false
        alertVC.correct = answer
        alertVC.answer = quiz.questions[quiz.currentQuestion].correction
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    
    //MARK: - Segueways
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCongratulations"{
            let destionationVC = segue.destination as! CongratulationsViewController
            destionationVC.correctAnswers = correctAnswers
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
