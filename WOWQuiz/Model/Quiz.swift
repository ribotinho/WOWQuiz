import Foundation
import RealmSwift

class Quiz {
    var questions : Results<Question>!
    var total : Int = 0
    var currentQuestion : Int!
    
    convenience init(with questions : Results<Question>) {
        self.init()
        self.currentQuestion = 0
        self.questions = questions
        self.total = questions.count
    }
    
    func isFinished() -> Bool{
        return currentQuestion < questions.count ? false : true
    }
    
    func isSelectedAnswerCorrect(for title : String) -> Bool{
        let answers = questions[currentQuestion].answers
        for answer in answers{
            if answer.title == title{
                return answer.isCorrect
            }
        }
        return false
    }
    
    func nextQuestion() {
        self.currentQuestion += 1
    }
    
}
