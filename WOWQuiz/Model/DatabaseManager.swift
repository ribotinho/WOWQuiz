import RealmSwift
import Foundation

struct DatabaseManager {
    
    private var realm : Realm
    static let sharedInstance = DatabaseManager()
    
    private init() {
        realm = try! Realm()
    }
    
    func getNextID() -> Int{
     return realm.objects(Question.self).map{$0.id}.max() ?? 0
     }
    
    func populateQuestion(){
        let answer1 = Answer("hola", true)
        let answer2 = Answer("hola2", false)
        let answer3 = Answer("hola3", false)
        let answer4 = Answer("hola4", false)
        let list = List<Answer>()
        list.append(answer1)
        list.append(answer2)
        list.append(answer3)
        list.append(answer4)
        
        let question = Question(id: 0, title: "això és una pregunta", level: 1, category: "rogue", correction: "hola", answers: list)
        let question2 = Question(id: 1, title: "això és una altra pregunta", level: 1, category: "rogue", correction: "hola", answers: list)
        
        try! realm.write {
            realm.add(question)
            realm.add(question2)
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
