import RealmSwift
import Foundation

class Answer: Object {
    @objc dynamic var title : String!
    @objc dynamic var questionID : Int = 0
    @objc dynamic var isCorrect : Bool = false
    
    
    convenience init(id : Int, _ title : String, _ isCorrect : Bool){
        self.init()
        self.questionID = id
        self.title = title
        self.isCorrect = isCorrect
    }
}
