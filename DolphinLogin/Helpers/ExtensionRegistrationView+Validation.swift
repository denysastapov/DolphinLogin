//
//  ExtensionRegistrationView+Validation.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 18.11.2023.
//

import UIKit

extension RegistrationViewController {
    
    private func validateAndSetBorderColor(for textField: UITextField, validationType: ValidationType) {
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5.0
        textField.clipsToBounds = true
        
        switch validationType {
        case .firstName:
            if ValidationFieldsHelper.isValidName(textField.text ?? "") {
                textField.layer.borderColor = UIColor.green.cgColor
            } else {
                textField.layer.borderColor = UIColor.red.cgColor
                if textField.text?.isEmpty ?? true {
                    textField.layer.borderColor = UIColor.lightGray.cgColor
                }
            }
        case .lastName:
            if ValidationFieldsHelper.isValidName(textField.text ?? "") {
                textField.layer.borderColor = UIColor.green.cgColor
            } else {
                textField.layer.borderColor = UIColor.red.cgColor
                if textField.text?.isEmpty ?? true {
                    textField.layer.borderColor = UIColor.lightGray.cgColor
                }
            }
        case .email:
            if ValidationFieldsHelper.isValidEmail(textField.text ?? "") {
                textField.layer.borderColor = UIColor.green.cgColor
            } else {
                textField.layer.borderColor = UIColor.red.cgColor
                if textField.text?.isEmpty ?? true {
                    textField.layer.borderColor = UIColor.lightGray.cgColor
                }
                showAlert(message: "Invalid email address. Please enter a valid email.")
            }
        case .password:
            if ValidationFieldsHelper.isValidPassword(textField.text ?? "") {
                textField.layer.borderColor = UIColor.green.cgColor
            } else {
                textField.layer.borderColor = UIColor.red.cgColor
                if textField.text?.isEmpty ?? true {
                    textField.layer.borderColor = UIColor.lightGray.cgColor
                }
                showAlert(message: "Invalid password. It must be at least 8 characters long, contain at least one capital letter, one number, and one special character.")
            }
        case .age:
            if ValidationFieldsHelper.isValidAge(textField.text ?? "") {
                textField.layer.borderColor = UIColor.green.cgColor
            } else {
                textField.layer.borderColor = UIColor.red.cgColor
                if textField.text?.isEmpty ?? true {
                    textField.layer.borderColor = UIColor.lightGray.cgColor
                }
                showAlert(message: "Invalid age. Please enter a valid age.")
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == passwordTextField {
            textField.isSecureTextEntry = false
        }
        if isValidRegistration() {
            updateGradientForButton()
        }
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == passwordTextField {
            textField.isSecureTextEntry = true
        }
        
        switch textField {
        case firstNameTextField:
            validateAndSetBorderColor(for: firstNameTextField, validationType: .firstName)
        case lastNameTextField:
            validateAndSetBorderColor(for: lastNameTextField, validationType: .lastName)
        case emailTextField:
            validateAndSetBorderColor(for: emailTextField, validationType: .email)
        case passwordTextField:
            validateAndSetBorderColor(for: passwordTextField, validationType: .password)
        case ageTextField:
            validateAndSetBorderColor(for: ageTextField, validationType: .age)
        default:
            break
        }
        
        if isValidRegistration() {
            updateGradientForButton()
        }
    }
    
    private func updateGradientForButton() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = registerButton.bounds
        gradientLayer.colors = isValidRegistration() ? [UIColor(hex: "#546bea").cgColor, UIColor(hex: "#2624e9").cgColor] : [UIColor.gray.cgColor, UIColor.darkGray.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.cornerRadius = 25
        
        registerButton.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func isValidRegistration() -> Bool {
        return ValidationFieldsHelper.isValidName(firstNameTextField.text ?? "") &&
        ValidationFieldsHelper.isValidName(lastNameTextField.text ?? "") &&
        ValidationFieldsHelper.isValidEmail(emailTextField.text ?? "") &&
        ValidationFieldsHelper.isValidPassword(passwordTextField.text ?? "") &&
        ValidationFieldsHelper.isValidAge(ageTextField.text ?? "")
    }
}
enum ValidationType {
    case firstName
    case lastName
    case email
    case password
    case age
}
