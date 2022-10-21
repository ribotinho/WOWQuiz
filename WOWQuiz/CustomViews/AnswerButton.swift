
import UIKit

class answerButton: UIButton {
    
    var checkImageView : UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    private func configureButton() {
        layer.cornerRadius = 15
        layer.borderWidth = 3
        layer.masksToBounds = true
        layer.borderColor = UIColor.black.cgColor
        setTitleColor(.white, for: .normal)
        setBackgroundImage(UIImage(named: "button background"), for: .normal)
        titleLabel?.font = UIFont(name: "Futura", size: 20.0)
    }
    
    
    
    private func configureImage(with image : String, with color : UIColor){
        checkImageView = UIImageView(image: UIImage(systemName: image))
        addSubview(checkImageView)
        checkImageView.tintColor = color
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        checkImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        checkImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        checkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    public func reset(){
        if checkImageView != nil {
            checkImageView.removeFromSuperview()
        }
        applyGradient(with: [UIColor.customBrown, UIColor.customDarkBrown], cornerRadius: 15)
    }
    
    public func blink(for answer : Bool){
        self.alpha = 0.2
        UIView.animate(withDuration: 0.2, animations: {
            UIView.modifyAnimations(withRepeatCount: 3, autoreverses: true) {
                self.alpha = 1.0
            }
        }) { (isFinished) in
            if answer{
                self.configureImage(with: "checkmark.circle", with: .green)
            }else{
                self.configureImage(with: "multiply.circle", with: .red)
            }
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient(with: [UIColor.customBrown, UIColor.customDarkBrown], cornerRadius: 15)
        
    }
}
