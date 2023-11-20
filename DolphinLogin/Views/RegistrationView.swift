//
//  RegistrationView.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 15.11.2023.
//

protocol RegistrationViewControllerDelegate: AnyObject {
    func registrationButtonPressed()
}

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    weak var delegate: RegistrationViewControllerDelegate?

    private let headerView: HeaderView = {
        let view = HeaderView()
        view.labelText = "Registration"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let firstNameTextField = TextFieldCreation.makeTextField(placeholder: "First Name")
    private let lastNameTextField = TextFieldCreation.makeTextField(placeholder: "Last Name")
    private let emailTextField = TextFieldCreation.makeTextField(placeholder: "Email", keyboardType: .emailAddress)
    private let passwordTextField = TextFieldCreation.makeTextField(placeholder: "Password", isSecureTextEntry: true)
    private let ageTextField = TextFieldCreation.makeTextField(placeholder: "Age", keyboardType: .numberPad)
    private let genderLabel = ControlsFactory.makeLabel(forText: "Gender")
    private let genderSegmentedControl = ControlsFactory.makeSegmentedControl()
    private let registerButton = ControlsFactory.makeRegisterButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        setupKeyboardHandling()
    }

    private func setupUI() {
        
        view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        ageTextField.delegate = self
        
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    /*
    private func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func handleTap() {
        self.endEditing(true)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = self.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 1.3) * -1
            self.frame.origin.y = newFrameY
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        print("keyboardWillHide")
        self.frame.origin.y = 0
        print("New y origin: \(self.frame.origin.y)")
    }

    private func adjustContentInsets(_ insets: UIEdgeInsets) {
        self.layoutMargins = insets
    }
    */
}

