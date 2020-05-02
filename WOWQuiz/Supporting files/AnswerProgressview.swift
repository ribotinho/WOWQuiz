import UIKit

class AnswerProgressView: UIView {

    var max : Int = 15
    var current : Int = 0
    var quitButton : UIButton!
    var progressview : UIView!
    var progressBarWidth : CGFloat = 50
    var widthConstraint = NSLayoutConstraint()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func configureView(){
        layer.cornerRadius = 15
        configureProgressView()
        configureButton()
        layer.borderColor = K.Colors.yellow.cgColor
        layer.borderWidth = 2
    }
    
    func configureProgressView(){
        progressview = UIView(frame: .zero)
        addSubview(progressview)
        widthConstraint.constant = 0
        progressview.translatesAutoresizingMaskIntoConstraints = false
        progressview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        progressview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        progressview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        progressview.widthAnchor.constraint(equalToConstant: progressBarWidth).isActive = true
        progressview.layer.cornerRadius = 15
        progressview.backgroundColor = K.Colors.yellow
    }
    
    func configureButton(){
        quitButton = UIButton()
        addSubview(quitButton)
        quitButton.translatesAutoresizingMaskIntoConstraints = false
        quitButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        quitButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        quitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        quitButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        quitButton.setBackgroundImage(UIImage(systemName: "multiply.circle"), for: .normal)
        quitButton.tintColor = .black
    }
    
    func updateCurrentWidth(){
        print("width \(progressview.frame.size.width)")
        current = current + 1


        progressBarWidth = CGFloat((self.current * Int(self.frame.size.width) / self.max))
        
        print(progressBarWidth)
        DispatchQueue.main.async {
            self.progressview.setNeedsUpdateConstraints()
        }
        
        print("width \(progressview.frame.size.width)")
    }

}
