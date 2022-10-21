//
//  UIView+Ext.swift
//  WOWQuiz
//
//  Created by Pau Ribot Pujolras on 21/10/22.
//  Copyright © 2022 Pau Ribot Pujolras. All rights reserved.
//

import UIKit

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
