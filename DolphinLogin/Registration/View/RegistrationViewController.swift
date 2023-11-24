//
//  RegistrationViewController.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 15.11.2023.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    var viewModel: RegistrationViewModel!
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.labelText = "Registration"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let firstNameTextField = TextFieldCreation.makeTextField(placeholder: "First Name")
    let lastNameTextField = TextFieldCreation.makeTextField(placeholder: "Last Name")
    let emailTextField = TextFieldCreation.makeTextField(placeholder: "Email", keyboardType: .emailAddress)
    let passwordTextField = TextFieldCreation.makeTextField(placeholder: "Password", isSecureTextEntry: true)
    let ageTextField = TextFieldCreation.makeTextField(placeholder: "Age", keyboardType: .numberPad)
    let genderLabel = ControlsFactory.makeLabel(forText: "Gender")
    let genderSegmentedControl = ControlsFactory.makeSegmentedControl()
    let registerButton = ControlsFactory.makeRegisterButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .white
        
        viewModel = RegistrationViewModel(networkService: NetworkService(), registrationViewContriller: self, navigationController: self.navigationController!)
        
        registerButton.addAction(UIAction(handler: { [weak self] _ in
            self?.registerButtonPressed()
        }), for: .touchUpInside)
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        ageTextField.delegate = self
        
        setupUI()
        setupKeyboardHandling()
    }
    
    private func setupUI() {
        
        let stackView = UIStackView(arrangedSubviews: [
            firstNameTextField,
            lastNameTextField,
            emailTextField,
            passwordTextField,
            genderLabel,
            genderSegmentedControl,
            ageTextField
        ])
        view.addSubview(headerView)
        view.addSubview(stackView)
        view.addSubview(registerButton)
        
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 320),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            
            firstNameTextField.heightAnchor.constraint(equalToConstant: 50),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            ageTextField.heightAnchor.constraint(equalToConstant: 50),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            registerButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            registerButton.widthAnchor.constraint(equalToConstant: 200),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func registerButtonPressed() {
        if isValidRegistration() {
            viewModel.register()
        } else {
            return
        }
    }
    
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
    
    func isValidRegistration() -> Bool {
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
