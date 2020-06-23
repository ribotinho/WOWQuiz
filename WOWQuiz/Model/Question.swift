import Foundation

struct Question :  Codable {
    var id : Int = 0
    var title : String!
    var level : Int = 0
    var category : String!
    var correction : String!
    var answers : [Answer]
    
}
