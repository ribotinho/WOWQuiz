
import UIKit

class answerButton: UIButton {
    
    let checkImageView : UIImageView = UIImageView(image: UIImage(systemName: "circle"))
    var hasBeenSelected : Bool = false {
        didSet{
            if hasBeenSelected{
                checkImageView.image = UIImage(systemName: "checkmark.circle.fill")
                configureSelectedButton()
            }else{
               checkImageView.image = UIImage(systemName: "circle")
                configureUnselectedButton()
            }
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureImage()
    }
    
    func configureSelectedButton(){
        backgroundColor = K.Colors.yellow
        checkImageView.tintColor = .white
        titleLabel?.textColor = .white
        layer.borderWidth = 0
    }
    
     func configureUnselectedButton() {
        checkImageView.tintColor = .lightGray
        backgroundColor = .clear
        layer.borderWidth = 3
        layer.borderColor = UIColor.lightGray.cgColor
        titleLabel?.textColor = .lightGray
    }
    
    func configureImage(){
        
        addSubview(checkImageView)
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        checkImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        checkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        checkImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        
        
    }
}
