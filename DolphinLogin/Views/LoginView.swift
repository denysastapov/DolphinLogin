//
//  LoginView.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 18.11.2023.
//

protocol LoginViewDelegate: AnyObject {
    func loginButtonPressed(username: String, password: String)
}

import UIKit

class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.makeHeaderLabel.text = "Login"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let usernameTextField = TextFieldCreation.makeTextField(placeholder: "Username")
    let passwordTextField = TextFieldCreation.makeTextField(placeholder: "Password", isSecureTextEntry: true)
    let loginButton = ControlsFactory.makeLoginButton()
    let registrationButton = ControlsFactory.makeRegisterButton()
    
    let dolphinImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "dolphin"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLoginViewUI()
        usernameTextField.text = "kminchelle"
        passwordTextField.text = "0lelplR"
        setupKeyboardHandling()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLoginViewUI(){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [
            usernameTextField,
            passwordTextField
        ])
        addSubview(headerView)
        addSubview(dolphinImage)
        addSubview(stackView)
        addSubview(loginButton)
        addSubview(registrationButton)
        
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 320),
            
            dolphinImage.heightAnchor.constraint(equalToConstant: 120),
            dolphinImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dolphinImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -40),
            
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            loginButton.bottomAnchor.constraint(equalTo: registrationButton.topAnchor, constant: -20),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            registrationButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            registrationButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            registrationButton.widthAnchor.constraint(equalToConstant: 200),
            registrationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func loginButtonPressed() {
        delegate?.loginButtonPressed(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
    }

    
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
            print("New y origin: \(self.frame.origin.y)")
            print(newFrameY)
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        print("keyboardWillHide")
        self.frame.origin.y = 0
//        print("New y origin: \(self.frame.origin.y)")
    }

//    private func adjustContentInsets(_ insets: UIEdgeInsets) {
//        self.layoutMargins = insets
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

