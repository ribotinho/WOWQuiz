import RealmSwift
import Foundation

struct DatabaseManager {
    
    private var realm : Realm
    static let sharedInstance = DatabaseManager()
    
    private init() {
        realm = try! Realm()
    }
    
    func getNextID() -> Int{
        if let currentMaxID = realm.objects(Question.self).map({$0.id}).max() {
            return currentMaxID + 1
        }else {
            return 0
        }
     }
    
    func populateQuestion(){
        let answer1 = Answer(id: 2, "hola", true)
        let answer2 = Answer(id: 2, "hola2", false)
        let answer3 = Answer(id: 2, "hola3", false)
        let answer4 = Answer(id: 2, "hola4", false)
        let list = List<Answer>()
        list.append(answer1)
        list.append(answer2)
        list.append(answer3)
        list.append(answer4)
        
        let question = Question(id: 2, title: "Who was XXXX", level: 1, category: "rogue", correction: "hola", answers: list)

        
        try! realm.write {
            realm.add(question)
        }
    }
    
    func getDataFromDB() ->   Results<Question> {
        let results: Results<Question> =   realm.objects(Question.self)
        return results
    }
    
    func addData(object: Question)   {
        try! realm.write {
            realm.add(object, update: .error)
            print("Added new object")
        }
    }
    
    func deleteAllFromDatabase()  {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func deleteFromDb(object: Question)   {
        try!   realm.write {
            realm.delete(object)
        }
    }
}
