import RealmSwift
import Foundation

class Question : Object {
    @objc dynamic var id : Int = 0
    @objc dynamic var title : String!
    @objc dynamic var level : Int = 0
    @objc dynamic var category : String!
    @objc dynamic var correction : String!
    dynamic var answers = List<Answer>()
    
    convenience init(id : Int, title : String, level : Int, category : String, correction : String, answers : List<Answer>) {
        self.init()
        self.id = id
        self.title = title
        self.level = level
        self.category = category
        self.correction = correction
        self.answers = answers
    }
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
