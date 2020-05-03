
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
        checkImageView.tintColor = K.Colors.yellow
        titleLabel?.textColor = K.Colors.yellow
        layer.borderWidth = 3
        layer.borderColor = K.Colors.yellow.cgColor
        backgroundColor = K.Colors.redQuest
    }
    
     func configureUnselectedButton() {
        checkImageView.tintColor = .lightGray
        backgroundColor = K.Colors.grayQuest
        titleLabel?.textColor = UIColor.lightGray
        layer.borderWidth = 3
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func configureImage(){
        layer.cornerRadius = 15
        addSubview(checkImageView)
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        checkImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        checkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        checkImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if hasBeenSelected{
            configureSelectedButton()
        }else{
            configureUnselectedButton()
        }
    }
}
