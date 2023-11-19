//
//  ControlsFactory.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 17.11.2023.
//

import UIKit

class ControlsFactory {
    
    static func makeLabel(forText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    static func makeSegmentedControl() -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: ["Male", "Female"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .blue
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }

    static func makeRegisterButton() -> UIButton {
        let button = UIButton()
        
        button.backgroundColor = .lightGray
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 4
        
        button.layer.cornerRadius = 25

        button.setTitleColor(.white, for: .normal)

        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.5

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)

        return button
    }
    
    static func makeLoginButton() -> UIButton {
        let button = UIButton()

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(hex: "#546bea").cgColor, UIColor(hex: "#2624e9").cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 50)

        gradientLayer.cornerRadius = 25

        gradientLayer.shadowColor = UIColor.black.cgColor
        gradientLayer.shadowOpacity = 0.5
        gradientLayer.shadowOffset = CGSize(width: 0, height: 4)
        gradientLayer.shadowRadius = 4

        button.layer.insertSublayer(gradientLayer, at: 0)

        button.setTitleColor(.white, for: .normal)

        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.5

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)

        return button
    }
}
