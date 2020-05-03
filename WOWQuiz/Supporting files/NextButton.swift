
import UIKit

class NextButton: UIView {
    
    var timerLabel = UILabel()
    var button = UIButton()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureImage()
    }
    
    func configureImage(){
        
        addSubview(timerLabel)
        addSubview(button)
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        timerLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        timerLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        timerLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        timerLabel.layer.masksToBounds = true
        timerLabel.layer.cornerRadius = 15
        timerLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        timerLabel.textAlignment = .center
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: timerLabel.trailingAnchor, constant: 10).isActive = true
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        button.titleLabel?.textAlignment = .center
        
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.textColor = .black
        
        timerLabel.text = "30"
        timerLabel.backgroundColor = .white
        
        layer.cornerRadius = 15
        backgroundColor = .clear
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.applyGradient(with: [K.Colors.yellow, K.Colors.orange], cornerRadius: 0)
    }
    
}






