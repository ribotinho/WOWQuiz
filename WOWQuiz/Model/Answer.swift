import RealmSwift
import Foundation

class Answer: Object {
    @objc dynamic var title : String!
    @objc dynamic var isCorrect : Bool = false
    
    convenience init(_ title : String, _ isCorrect : Bool){
        self.init()
        self.title = title
        self.isCorrect = isCorrect
    }
}
