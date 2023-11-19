//
//  RegistrationView.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 15.11.2023.
//

import UIKit

class RegistrationView: UIView, UITextFieldDelegate {

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
//        setupKeyboardHandling()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        ageTextField.delegate = self
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//        self.addGestureRecognizer(tapGesture)
        
        let stackView = UIStackView(arrangedSubviews: [
            firstNameTextField,
            lastNameTextField,
            emailTextField,
            passwordTextField,
            genderLabel,
            genderSegmentedControl,
            ageTextField
        ])
        addSubview(headerView)
        addSubview(stackView)
        addSubview(registerButton)
        
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 320),
            
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -20),
            
            firstNameTextField.heightAnchor.constraint(equalToConstant: 50),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            ageTextField.heightAnchor.constraint(equalToConstant: 50),
            
            registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            registerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            registerButton.widthAnchor.constraint(equalToConstant: 200),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
//    private func setupKeyboardHandling() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    @objc private func handleTap() {
//        self.endEditing(true)
//    }
//
//    @objc private func keyboardWillShow(_ notification: Notification) {
//        guard let userInfo = notification.userInfo,
//              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
//              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
//        
//        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
//        let convertedTextFieldFrame = self.convert(currentTextField.frame, from: currentTextField.superview)
//        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
//
//        if textFieldBottomY > keyboardTopY {
//            let textBoxY = convertedTextFieldFrame.origin.y
//            let newFrameY = (textBoxY - keyboardTopY / 1.3) * -1
//            self.frame.origin.y = newFrameY
//        }
//    }
//
//    @objc private func keyboardWillHide(_ notification: Notification) {
//        print("keyboardWillHide")
//        self.frame.origin.y = 0
//        print("New y origin: \(self.frame.origin.y)")
//    }
//
//    private func adjustContentInsets(_ insets: UIEdgeInsets) {
//        self.layoutMargins = insets
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    
}
