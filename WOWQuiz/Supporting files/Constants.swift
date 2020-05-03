import UIKit
import Foundation

struct K {
    static let backgroundImage = ["background_2","background_3","background_3","background_4","background_6","background_7",]
    
    struct Font {
        static let title : String = "LifeCraft_Font.ttf"
        static let size : CGFloat = 17.0
    }
    
    struct Colors {
        static let prusianBlue = UIColor(red: 0/255, green: 49/255, blue: 81/255, alpha: 1)
        static let bluish = UIColor(red: 96/255, green: 101/255, blue: 208/255, alpha: 1)
        static let darkBlue = UIColor(red: 18/255, green: 1/255, blue: 54/255, alpha: 1)
        static let blue = UIColor(red: 3/255, green: 90/255, blue: 166/255, alpha: 1)
        static let lightBlue = UIColor(red: 64/255, green: 186/255, blue: 213/255, alpha: 1)
        static let yellow = UIColor(red: 252/255, green: 191/255, blue: 30/255, alpha: 1)
        static let reallyDarkBlue = UIColor(red: 34/255, green: 40/255, blue: 49/255, alpha: 1)
        static let orange = UIColor(red: 255/255, green: 116/255, blue: 23/255, alpha: 1)
        static let redQuest = UIColor(red: 100/255, green: 10/255, blue: 0/255, alpha: 1)
        static let grayQuest = UIColor(red: 50/255, green: 49/255, blue: 50/255, alpha: 1)
    }
}

extension UIView {
    
    func applyGradient(with colours: [UIColor], locations: [NSNumber]? = nil, cornerRadius : CGFloat) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.cornerRadius = cornerRadius
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.layer.insertSublayer(gradient, at: 0)
    }
}


