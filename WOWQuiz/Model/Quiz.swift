import Foundation

struct Quiz {
    var questions : [Question]
    var total : Int = 0
    var currentQuestion : Int = 0
    
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
    
    mutating func nextQuestion() {
        self.currentQuestion += 1
    }
    
}
