import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var startGameButon: UIButton!
    var quizGame : Quiz{
        let quiz = Quiz(questions: loadQuestions().shuffled(), total: 15, currentQuestion: 0)
        return quiz
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "startGameSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGameSegue"{
            let destionationVC = segue.destination as! GameViewController
            destionationVC.quiz = quizGame
        }
    }
    
    func loadQuestions() -> [Question]{
        if let url = Bundle.main.url(forResource: "quizData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Array<Question>.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return [Question]()
    }
    
    private func configureUI(){
        startGameButon.backgroundColor = .red
        startGameButon.setTitle("START GAME", for: .normal)
        startGameButon.layer.cornerRadius = 10
        
        startGameButon.layer.shadowColor = UIColor.white.cgColor
        startGameButon.layer.shadowOpacity = 10
        startGameButon.layer.shadowRadius = 15
    }

}
