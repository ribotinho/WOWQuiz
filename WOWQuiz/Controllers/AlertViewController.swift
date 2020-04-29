//
//  AlertViewController.swift
//  WOWQuiz
//
//  Created by Pau Ribot Pujolras on 29/04/2020.
//  Copyright © 2020 Pau Ribot Pujolras. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    var delegate : AlertDelegate?
    var correct : Bool!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    static let identifier = "AlertVC"

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

    }
    
    func configureUI(){
        if correct{
            headerTitleLabel.text = "CORRECT!"
            headerView.backgroundColor = .green
            nextButton.setTitle("Next question", for: .normal)
        }else{
            headerTitleLabel.text = "INCORRECT!"
            headerView.backgroundColor = .red
            nextButton.setTitle("Try again!", for: .normal)
        }
    }
    
    @IBAction func nextQuesstionButtonTapped(_ sender: Any) {
        if correct{
            dismiss(animated: true, completion: nil)
            delegate?.didTapNextQuestion()
        }else{
            dismiss(animated: true, completion: nil)
            delegate?.didFailQuestion()
        }
    }
    
}

protocol AlertDelegate {
    func didTapNextQuestion()
    func didFailQuestion()
}
