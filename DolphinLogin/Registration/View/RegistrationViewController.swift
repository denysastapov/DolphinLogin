//
//  RegistrationViewController.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 15.11.2023.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate{
    
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
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        ageTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        
        registerButton.addAction(UIAction(handler: { [weak self] _ in
            self?.registerButtonPressed()
        }), for: .touchUpInside)
        
        genderSegmentedControl.addAction(UIAction(handler: { [ weak self ] _ in
            guard let self = self else { return }
            let newUserGender = self.genderSegmentedControl.titleForSegment(at: self.genderSegmentedControl.selectedSegmentIndex) ?? ""
            self.viewModel.setUpUserGender(userGender: newUserGender)
        }), for: .valueChanged)
        
        let newUserGender = self.genderSegmentedControl.titleForSegment(at: self.genderSegmentedControl.selectedSegmentIndex) ?? ""
        self.viewModel.setUpUserGender(userGender: newUserGender)
        
        viewModel.isUserEmailValid = { [ weak self ] isUserEmailValid in
            if isUserEmailValid {
                self?.emailTextField.layer.borderColor = UIColor.green.cgColor
            } else {
                self?.emailTextField.layer.borderColor = UIColor.red.cgColor
                self?.showAlert(message: "Invalid email address. Please enter a valid email.")
                if self?.emailTextField.text?.isEmpty ?? true {
                    self?.emailTextField.layer.borderColor = UIColor.lightGray.cgColor
                }
            }
        }
        
        viewModel.isUserFirstNameValid = { [ weak self ] isUserFirstNameValid in
            if isUserFirstNameValid {
                self?.firstNameTextField.layer.borderColor = UIColor.green.cgColor
            } else {
                self?.firstNameTextField.layer.borderColor = UIColor.red.cgColor
                if self?.firstNameTextField.text?.isEmpty ?? true {
                    self?.firstNameTextField.layer.borderColor = UIColor.lightGray.cgColor
                }
            }
        }
        
        viewModel.isUserLastNameValid = { [ weak self ] isUserLastNameValid in
            if isUserLastNameValid {
                self?.lastNameTextField.layer.borderColor = UIColor.green.cgColor
            } else {
                self?.lastNameTextField.layer.borderColor = UIColor.red.cgColor
                if self?.lastNameTextField.text?.isEmpty ?? true {
                    self?.lastNameTextField.layer.borderColor = UIColor.lightGray.cgColor
                }
            }
        }
        
        viewModel.isUserPasswordValid = { [ weak self ] isUserPasswordValid in
            if isUserPasswordValid {
                self?.passwordTextField.layer.borderColor = UIColor.green.cgColor
            } else {
                self?.passwordTextField.layer.borderColor = UIColor.red.cgColor
                self?.showAlert(message: "Invalid password. It must be at least 8 characters long, contain at least one capital letter, one number, and one special character.")
                if self?.passwordTextField.text?.isEmpty ?? true {
                    self?.passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
                }
            }
        }
        
        viewModel.isUserAgeValid = { [ weak self ] isUserAgeValid in
            if isUserAgeValid {
                self?.ageTextField.layer.borderColor = UIColor.green.cgColor
            } else {
                self?.ageTextField.layer.borderColor = UIColor.red.cgColor
                self?.showAlert(message: "Invalid age. Please enter a valid age.")
                if self?.ageTextField.text?.isEmpty ?? true {
                    self?.ageTextField.layer.borderColor = UIColor.lightGray.cgColor
                }
            }
        }
        
        emailTextField.addAction(UIAction(handler: { [ weak self ] _ in
            guard let self = self else { return }
            let newUserEmail = self.emailTextField.text ?? ""
            self.viewModel.setUpUserEmail(userEmail: newUserEmail)
        }), for: .editingDidEnd)
        
        firstNameTextField.addAction(UIAction(handler: { [ weak self ] _ in
            guard let self = self else { return }
            let newUserFirstName = self.firstNameTextField.text ?? ""
            self.viewModel.setUpUserFirstName(userFirstName: newUserFirstName)
        }), for: .editingDidEnd)
        
        lastNameTextField.addAction(UIAction(handler: { [ weak self ] _ in
            guard let self = self else { return }
            let newUserLastName = self.lastNameTextField.text ?? ""
            self.viewModel.setUpUserLastName(userLastName: newUserLastName)
        }), for: .editingDidEnd)
        
        passwordTextField.addAction(UIAction(handler: { [ weak self ] _ in
            guard let self = self else { return }
            let newUserPassword = self.passwordTextField.text ?? ""
            self.viewModel.setUpUserPassword(userPassword: newUserPassword)
        }), for: .editingDidEnd)
        
        ageTextField.addAction(UIAction(handler: { [ weak self ] _ in
            guard let self = self else { return }
            let newUserAge = self.ageTextField.text ?? ""
            self.viewModel.setUpUserAge(userAge: newUserAge)
        }), for: .editingDidEnd)
        
        setupUI()
        setupKeyboardHandling()
    }
    
    private func setupUI() {
        
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .white
        
        viewModel.navigationController = navigationController
        
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
            let alert = UIAlertController(title: "Validation Error", message: "Please complete all fields", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
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
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == passwordTextField {
            textField.isSecureTextEntry = true
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
